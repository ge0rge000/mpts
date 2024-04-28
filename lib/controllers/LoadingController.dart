import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs; // Reactive variable

  void startLoading() {
    isLoading.value = true;
    // Simulate loading data
    Future.delayed(Duration(seconds: 3), stopLoading);
  }

  void stopLoading() {
    isLoading.value = false;
  }
}
