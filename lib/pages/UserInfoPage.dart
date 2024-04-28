import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_app/controllers/UserControllerInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfoPage extends StatelessWidget {
  final UserControllerInfo userController = Get.put(UserControllerInfo(), permanent: false);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              "Name: ${userController.name?.value}",
              style: TextStyle(fontSize: 18),
            )),
            SizedBox(height: 10),
            Obx(() => Text(
              "Email: ${userController.email?.value}",
              style: TextStyle(fontSize: 18),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userController.logout();
              },style: ElevatedButton.styleFrom(
              primary: Colors.black, // Sets the background color of the button to black
            ),
              child: Text("Logout",   style: TextStyle(
                color: Colors.white,
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
