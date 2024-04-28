import 'dart:convert';

import 'package:get/get.dart';
import 'package:remote_app/APIS/ApiService.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GatewayPageController extends GetxController {
var first=false.obs;
var secound=false.obs;
var third=false.obs;
var isLoading = false.obs;
late WebSocketChannel channel;

final RxString receivedData = ''.obs;



var products = <Map<String, dynamic>>[].obs;
  final ApiService _apiService = ApiService();
  Timer? _timer;
  final ApiService apiService = ApiService();
@override
Future<void> onInit() async {
  super.onInit();

  final prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('user_id');
  if (userId != null) {
    await loadUserPerm(userId);
  } else {
    print("no access");
  }
 loadProducts();
   _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => loadProducts());
}

Future<void> loadUserPerm(int userId) async {
  isLoading.value = true; // Start loading
  try {
    var fetchedPermission = await _apiService.getPermissions(userId);
    print(fetchedPermission);
    first.value= fetchedPermission.first  ?? false;
    secound.value= fetchedPermission.secound ?? false;
    third.value = fetchedPermission.third ?? false;
    print(third);
  } catch (e) {
    print('Failed to load permissions: $e');
  }
  finally{
    isLoading.value = false; // Stop loading once data is fetched or an error occurs

  }
}
  void loadProducts() async {
    try {
      var apiService = ApiService(); // Your API service
      var fetchedProducts = await apiService.getProduct();
      var newProducts = fetchedProducts.map((product) => {
        'id': product.id,
        'name': product.name,
        'case': product.productCase
      }).toList();

      if (json.encode(newProducts) != json.encode(products.value)) {
        products.value = newProducts;
      }
    } catch (e) {
      print('Failed to load features: $e');
    }
    finally{
    }

  }



}

