// Define a controller class to manage the state of the BottomNavigationBar
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs;
var role;
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
  Future<void> onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
     role = prefs.getString('role');
  }
}



