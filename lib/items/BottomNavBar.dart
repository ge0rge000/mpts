import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remote_app/pages/GateFeaturesONOFF.dart';
import 'package:remote_app/pages/GatewayControlPage.dart';
import 'package:remote_app/pages/NewUser.dart';
import 'package:remote_app/pages/UserInfoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/BottomNavBarController.dart';
import '../pages/UsersPage.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavBarController bottomNavBarController = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: bottomNavBarController.currentIndex.value,
          children: [
            GatewayControlPage(),
            UserInfoPage(),
            UsersPage(),
            NewUser(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: bottomNavBarController.currentIndex.value,
        onTap: (index) {
          bottomNavBarController.changeTabIndex(index);
        },
        items: _buildBottomNavBarItems(),
        backgroundColor: Colors.white, // Background color of the BottomNavigationBar
        type: BottomNavigationBarType.fixed, // Ensures the bar doesn't move
        unselectedItemColor: Colors.black, // Color of unselected items
        selectedItemColor: Colors.black, // Change this to your desired color for selected items
      )),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems() {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_pin),
        label: 'About',  // Always include at least a second item
      )
    ];
    if (bottomNavBarController.role == "ADM") {
      items.addAll([
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Add New User',
        ),
      ]);
    }

    return items;
  }
}

