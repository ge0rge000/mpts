import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:remote_app/pages/LoginPage.dart';
import 'package:flutter_animate/flutter_animate.dart';


import 'GatewayControlPage.dart';

class LoaderPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds:3), () {

      Get.offAll(() => LoginPage());
    });

    return Scaffold(
      backgroundColor: Colors.white,  // Set the background color to white
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Animate(
                  effects: [FadeEffect(), ScaleEffect()],
                  child: Image.asset('assets/logo.webp')).animate()
                  .fade(duration: 500.ms)
                  .scale(delay: 500.ms), // Display the loading GIF
              SizedBox(height: 20), // Add some vertical spacing
              Text("MPTS", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
              Text("Madam Baassiri", style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700])),
            ],
          ),
        ),
      ),
    );
  }
}
