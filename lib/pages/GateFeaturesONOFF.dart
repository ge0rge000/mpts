
import 'package:flutter/material.dart';
 import 'package:get/get.dart';

import 'package:remote_app/controllers/FeatureController.dart';
import 'package:remote_app/items/Buttons.dart';
import 'package:remote_app/items/Features.dart';

class GateFeaturesONOFF extends StatelessWidget {


  final FeatureController controller = Get.put(FeatureController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Map<String, dynamic> args = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args['name'],style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Buttons_on_off(),
          Features(),
        ],
      ),
    );
  }
}
