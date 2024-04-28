import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:remote_app/APIS/ApiService.dart';
import 'package:remote_app/pages/UsersPage.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var productList = [].obs; // This will hold the list of products
  final RxSet<int> selectedProducts = <int>{}.obs;

  var users = <Map<String, dynamic>>[].obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    fetchProducts();
    fetchUsers();
    super.onInit();
  }
  void toggleProduct(int id) {
    print('Toggling product ID: $id');
    print('Current selected products before toggle: $selectedProducts');
    if (selectedProducts.contains(id)) {
      selectedProducts.remove(id);
      print('Removed $id, selected products now: $selectedProducts');
    } else {
      selectedProducts.add(id);
      print('Added $id, selected products now: $selectedProducts');
    }
    update();
  }


  void fetchProducts() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('https://gpio.mpts-me.com/api/products'),
        headers: {'Content-Type': 'application/json'},
      );
      isLoading(false);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        productList.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', 'An error occurred: $e');
    }
    update();
  }


  void addUser(String name,  String password) async {
    isLoading(true);

    try {

      var response = await http.post(
        Uri.parse('https://gpio.mpts-me.com/api/save-selections'),
        headers: {
          'Content-Type': 'application/json', // Assuming your API expects JSON
        },
        body: jsonEncode({
          'name': name,
          'email': name+"@mpts-me.com",
          'password': password,
          'selected_products': Map.fromIterable(
              selectedProducts.toList(),
              key: (item) => item.toString(), // Convert each integer ID to a string
              value: (item) => true          // Set each value to true
          )
        }),

      );

      isLoading(false);

      if (response.statusCode == 200) {
        // Success, handle accordingly
        Get.snackbar('Success', 'User added successfully', snackPosition: SnackPosition.BOTTOM);
      } else {
        // Error, handle accordingly
        Get.snackbar('Error', 'Failed to add user', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading(false);
      print(e);  // Print the error to the console
      Get.snackbar('Exception', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  void fetchUsers() async {
    try {
      var apiService = ApiService(); // Your API service
      var fetchedUsers = await apiService.getUsers();
      if (fetchedUsers is List) {
        // Map the list of User objects to a list of maps.
        users.value = List<Map<String, dynamic>>.from(fetchedUsers.map((user) {
          return {
            'id': user.id,
            'name': user.name,
            'access_type': user.accessType,
          };
        }).toList());
      } else {
        // Handle the case where fetchedUsers is not a List
        print('The fetched data is not a list');
      }
    } catch (e) {
      print('Failed to load users: $e');
    }
  }

// void deleteUser(int id) {
  //   users.removeWhere((user) => user['id'] == id);
  //   // You might want to also send a request to the API to delete the user
  // }
}

