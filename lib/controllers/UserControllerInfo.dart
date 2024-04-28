import 'package:get/get.dart';
import 'package:remote_app/controllers/LoginController.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserControllerInfo extends GetxController {
  // Example user information
  var name = RxString('');
  var email = RxString('');
  Future<void> onInit() async {

    final prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';

    super.onInit();
  }
  void logout() {
    TokenService.deleteToken();
    Get.offAllNamed('/login');
  }
}
