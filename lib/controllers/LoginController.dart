import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../firebase_options.dart';
import '../items/BottomNavBar.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  final TokenService tokenService = Get.find();

  void login(String username, String password) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    print(username+"@mpts-me.com");
    try {
      var response = await http.post(
        Uri.parse('https://gpio.mpts-me.com/api/login'),

        body: {'email': username+"@mpts-me.com", 'password': password},
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)['token'];
        TokenService.saveToken(token);
        var user_id = jsonDecode(response.body)['data']['id'];
        var role = jsonDecode(response.body)['data']['role'];
        var email = jsonDecode(response.body)['data']['email'];
        var name = jsonDecode(response.body)['data']['name'];

        await  prefs.setInt('user_id', user_id);
        await  prefs.setString('role', role);
        await  prefs.setString('email', email);
        await  prefs.setString('name', name);

        final String _baseUrl = 'https://gpio.mpts-me.com/api';
        var userId = prefs.getInt('user_id');
        var token_firebase;
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
        token_firebase = await FirebaseMessaging.instance.getToken();

        var url = Uri.parse('$_baseUrl/firebasetoken/$userId/$token_firebase');
        print(url);

        final responsee = await http.get(url);

        if (responsee.statusCode == 200) {
          var jsonData = responsee.body;
          print(jsonData);
        }

        var headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type if necessary
        };

        var anotherResponse = await http.get(
          Uri.parse('https://example.com/another/api/endpoint'),
          headers: headers,
        );
        Get.offAll( BottomNavBar(), arguments: {'user_id': user_id});

      } else {
        Get.snackbar('Login Failed', 'Invalid username or password');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Failed', 'Error connecting to the server');
    }
  }
}
class TokenService {
  static const String _tokenKey = 'userToken';

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
// class AuthMiddleware extends GetMiddleware {
//   final TokenService _tokenService = Get.find();
//
//   @override
//   RouteSettings? redirect(String? route) {
//     if (_tokenService.tokenKey == null) {
//       // User is not authenticated, redirect to login page
//       return RouteSettings(name: '/login');
//     }
//     // User is authenticated, allow navigation
//     return null;
//   }
// }