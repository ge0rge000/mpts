import 'dart:ffi';

import 'package:get/get.dart';
import 'package:remote_app/APIS/ApiService.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FeatureController extends GetxController {
 var product_id = Get.arguments['product_id'];
  var features = <Map<String, dynamic>>[].obs; // Observable list of features
  Timer? _timer;
  final ApiService _apiService = ApiService();
  @override
  void onInit() {
    super.onInit();
    print(product_id);
    loadProductFeatures(product_id);
   _timer = Timer.periodic(Duration(seconds: 3), (Timer t) =>  loadProductFeatures(product_id));
  }
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  /// on and off
  void _handleApiResponse(http.Response response) {
    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void openCloseCommand(var productId,String caseCmd) async {
    try {
      final response = await _apiService.sendCommand(productId.toString() , caseCmd);
      _handleApiResponse(response);
    } catch (e) {
      print('Failed to send command: $e');
    }
  }
  ///update feature
  void loadProductFeatures(int productId) async {
    try {
      var fetchedFeatures = await _apiService.getProductFeatures(productId);
      features.value = fetchedFeatures.map((feature) => {'name': feature.name, 'value': feature.value}).toList();
    } catch (e) {
      print('Failed to load features: $e');
    }
  }

}
