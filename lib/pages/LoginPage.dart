import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_app/controllers/LoginController.dart';

import 'package:flutter_animate/flutter_animate.dart';



class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Animate(
                effects: [FadeEffect(), ScaleEffect()],
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    'assets/m.png', // Adjust the path to your image
                  ).animate().slide()// baseline=800ms

                      // inherits the delay & duration from move,
                ),
              ),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black), // Set the label text color to black
                  hintText: 'Enter your username',
                  suffixText: '@mpts-me.com',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),

              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',


                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // sets the background color to black
                ),
                child: loginController.isLoading.value
                    ? CircularProgressIndicator(color:Colors.black)
                    : Text('Login', style: TextStyle(color: Colors.white)), // ensures text is visible on black
                onPressed: loginController.isLoading.value
                    ? null
                    : () {
                  loginController.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
