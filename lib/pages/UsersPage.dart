import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/UserPermissionController.dart';

class UsersPage extends StatelessWidget {
  final UserPermissionController userController = Get.put(UserPermissionController(), permanent: false);


  void confirmDelete(BuildContext context, int userId) {
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton(
            child: Text('Delete'),
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              userController.deleteUser(userId);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users and Permissions'),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (userController.users.isEmpty) {
          return Center(child: Text('No users found.')); // Show a message if the list is empty
        }
        return ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            final user = userController.users[index];
            final userName = user['name'] ?? 'No Name Provided';
            final userEmail = user['email'] ?? 'No Email Provided';
            final Map<String, bool> accessTypes = user['accessType'] ?? {};

            // Widget to visualize access rights with labels
            Widget accessRights = Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Swing Gate', style: TextStyle(fontSize: 10)),
                    Icon(accessTypes['1'] ?? false ? Icons.check : Icons.close,
                        color: accessTypes['1'] ?? false ? Colors.green : Colors.red),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sliding Gate', style: TextStyle(fontSize: 10)),
                    Icon(accessTypes['2'] ?? false ? Icons.check : Icons.close,
                        color: accessTypes['2'] ?? false ? Colors.green : Colors.red),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Swing Door', style: TextStyle(fontSize: 10)),
                    Icon(accessTypes['3'] ?? false ? Icons.check : Icons.close,
                        color: accessTypes['3'] ?? false ? Colors.green : Colors.red),
                  ],
                ),
              ],
            );

            return ListTile(
              title: Text(userName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userEmail),
                  SizedBox(height: 8), // Adds space between email and access rights
                  accessRights, // Display the access rights below the email
                ],
              ),
                trailing: user['role'] != "ADM" ? IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (user['id'] != null) {
                      confirmDelete(context, user['id']);
                    }
                  },
                ) : null,
            );
          },
        );
      }),
    );
  }
}
