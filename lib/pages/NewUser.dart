  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:remote_app/controllers/UserController.dart';

  class NewUser extends StatelessWidget {
    final UserController userController = Get.put(UserController(), permanent: false);


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('New User'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(userController.nameController, 'Name', Icons.person),
                SizedBox(height: 10,),
                _buildTextField(userController.passwordController, 'Password', Icons.lock, obscureText: true),
                _buildProductList(),
                SizedBox(height: 16.0),
                _buildAddUserButton(),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildTextField(
        TextEditingController controller, String label, IconData icon,
        {bool emailInput = false, bool obscureText = false}) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        keyboardType: emailInput ? TextInputType.emailAddress : TextInputType.text,
        obscureText: obscureText,
      );
    }

    Widget _buildProductList() {
      return GetBuilder<UserController>(
        init: UserController(),
        builder: (userController) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: userController.productList.length,
            itemBuilder: (context, index) {
              var product = userController.productList[index];
              bool isSelected = userController.selectedProducts.contains(product['id']);
              return CheckboxListTile(
                title: Text(product['name']),
                value: isSelected,
                onChanged: (newValue) {
                  userController.toggleProduct(product['id']);
                },
                activeColor: Colors.black,
              );
            },
          );
        },
      );
    }

    Widget _buildAddUserButton() {
      return ElevatedButton.icon(
        icon: Icon(Icons.add),
        label: Text('Add User'),
        onPressed: () {
          if (userController.selectedProducts.isNotEmpty) {
            userController.addUser(
              userController.nameController.text,
              userController.passwordController.text,
            );
          } else {
            Get.snackbar('Error', 'Please select at least one product');
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
      );
    }
  }
