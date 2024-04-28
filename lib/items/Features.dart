import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/FeatureController.dart';


class Features extends StatelessWidget {


  final FeatureController controller = Get.put(FeatureController());
  String removeDigits(String input) {
    return input.replaceAll(RegExp(r'\d+'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: controller.features.length,
        itemBuilder: (context, index) {
          final feature = controller.features[index];
          final bool isActive = feature['value'] != '0';
          IconData iconData;
          Color iconColor;
          String displayText = feature['name'];
          Color ledColor;

          switch (feature['name']) {
            case 'open':
              iconData = Icons.lock_open;
              iconColor = Colors.green;
              ledColor = isActive ? Colors.green : Colors.grey; // Green when active, grey otherwise

              break;
            case 'close':
              iconData = Icons.lock;
              iconColor = Colors.red;
              ledColor = isActive ? Colors.red : Colors.grey; // Red when active, grey otherwise
              break;
            case 'bell':
              iconData = Icons.notifications_active;
              iconColor = Colors.blue;
              ledColor = isActive ? Colors.blue : Colors.grey; // Blue when active, grey otherwise


              break;
            case 'failue':
              iconData = Icons.error;
              if (isActive) {
                displayText = 'Failure';
                iconColor = Colors.red; // Red for failure
                ledColor = Colors.red; // LED red when failure is active
              } else {
                displayText = 'Working Good';
                iconColor = Colors.green; // Green when operational
                ledColor = Colors.green; // LED green when working good
              }
              break;
            case 'open2':
              iconData = Icons.lock_open;
              iconColor = Colors.green;
              ledColor = isActive ? Colors.green : Colors.grey; // Green when active, grey otherwise

              break;
            case 'close2':
              iconData = Icons.lock;
              iconColor = Colors.red;
              ledColor = isActive ? Colors.red : Colors.grey; // Red when active, grey otherwise
              break;
            case 'bell2':
              iconData = Icons.notifications_active;
              iconColor = Colors.blue;
              ledColor = isActive ? Colors.blue : Colors.grey; // Blue when active, grey otherwise


              break;
            case 'failue2':
              iconData = Icons.error;
              if (isActive) {
                displayText = 'Failure';
                iconColor = Colors.red; // Red for failure
                ledColor = Colors.red; // LED red when failure is active
              } else {
                displayText = 'Working Good';
                iconColor = Colors.green; // Green when operational
                ledColor = Colors.green; // LED green when working good
              }
              break;
            case 'open3':
              iconData = Icons.lock_open;
              iconColor = Colors.green;
              ledColor = isActive ? Colors.green : Colors.grey; // Green when active, grey otherwise

              break;
            case 'close3':
              iconData = Icons.lock;
              iconColor = Colors.red;
              ledColor = isActive ? Colors.red : Colors.grey; // Red when active, grey otherwise
              break;
            case 'bell3':
              iconData = Icons.notifications_active;
              iconColor = Colors.blue;
              ledColor = isActive ? Colors.blue : Colors.grey; // Blue when active, grey otherwise


              break;
            case 'failue3':
              iconData = Icons.error;
              if (isActive) {
                displayText = 'Failure';
                iconColor = Colors.red; // Red for failure
                ledColor = Colors.red; // LED red when failure is active
              } else {
                displayText = 'Working Good';
                iconColor = Colors.green; // Green when operational
                ledColor = Colors.green; // LED green when working good
              }
              break;
            default:
              iconData = Icons.device_unknown;
              iconColor = Colors.grey;
              ledColor = Colors.grey; // Grey for unknown or inactive statuses
          }

          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            leading: Icon(
              iconData,
              color: iconColor,
            ),
            title: Text(
                removeDigits(displayText),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ledColor, // Color changes based on active status and specific feature logic
                border: Border.all(color: Colors.black54, width: 1),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      )),
    );
  }
}
