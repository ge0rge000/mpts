import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:remote_app/APIS/ApiService.dart';

class UserPermissionController extends GetxController {

  var users = <Map<String, dynamic>>[].obs;
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  _timer = Timer.periodic(Duration(seconds: 3), (Timer t) =>  fetchUsers());
  }
  void fetchUsers() async {
    try {
      var apiService = ApiService(); // Your API service
      var fetchedUsers = await apiService.getUsers();
      if (fetchedUsers is List) {
        users.value = List<Map<String, dynamic>>.from(fetchedUsers.map((user) {
          return {
            'id': user.id ,
            'name': user.name,
            'accessType': user.accessType ,
            'email':user.email,
            'role':user.role
          };
        }).toList());
      } else {
        print('The fetched data is not a list');
      }
    } catch (e) {
      print('Failed to load users: $e');
    }
  }


  void deleteUser(int id) async {
        final String _baseUrl = 'https://gpio.mpts-me.com/api';
        var url = Uri.parse('$_baseUrl/delete_user/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      users.removeWhere((user) => user['id'] == id);
    } else {
      print('Failed to delete user: ${response.body}');
    }
  }
}

