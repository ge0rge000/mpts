
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:remote_app/models/AccessUser.dart';
import 'package:remote_app/models/Feature.dart';
import 'package:remote_app/models/Product.dart';
import 'package:remote_app/models/User.dart';
import 'package:remote_app/models/UserPermission.dart';

class ApiService {
  final String _baseUrl = 'https://gpio.mpts-me.com/api/status';
  //on &off
  Future<http.Response> sendCommand(String id, String caseCmd) async {
    var url = Uri.parse('$_baseUrl/$id/$caseCmd');
    print(url);
    http.Response response;
    try {
      response = await http.get(url);
    } on Exception catch (e) {
      print('Caught exception: $e');
      // You may want to throw a custom error or return a default response.
      throw e;
    }
    return response;
  }

  Future<List<Product>>  getProduct() async {
    final String _baseUrl = 'https://gpio.mpts-me.com/api';
    var url = Uri.parse('$_baseUrl/products/');
    print(url);
    final response = await http.get(url);
    if(response.statusCode==200){
      var jsonData=response.body;
      print(jsonData);
      return productFromJson(jsonData);
    }else{
      return throw Exception("failed to load ");
    }
  }
   Future<List<Feature>>  getProductFeatures(var productId) async {
    final String _baseUrl = 'https://gpio.mpts-me.com/api';
    var url = Uri.parse('$_baseUrl/product/$productId');
    print(url);
    final response = await http.get(url);
    if(response.statusCode==200){
      var jsonData=response.body;
      print(jsonData);
      return featureFromJson(jsonData);
    }else{
      return throw Exception("failed to load ");
    }

  }
  Future<List<UserPermission>>getUsers() async {
    final String _baseUrl = 'https://gpio.mpts-me.com/api';
    var url = Uri.parse('$_baseUrl/users/');
    print(url);
    final response = await http.get(url);
    if(response.statusCode==200){
      var jsonData=response.body;
      print(jsonData);
      return userPermissionFromJson(jsonData);
    }else{
      return throw Exception("failed to load ");
    }
  }
  Future<AccessUser> getPermissions(var userId) async {
    final String _baseUrl = 'https://gpio.mpts-me.com/api';
    var url = Uri.parse('$_baseUrl/check_user/$userId');
    final response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      var accessUser = AccessUser(
        first: jsonData['first']== '1',
        secound: jsonData["secound"] == '1',
        third: jsonData['third'] == '1',
      );
      return accessUser;
    } else {
      // Handle the case where the HTTP request fails
      throw Exception('Failed to load');
    }
  }


}
