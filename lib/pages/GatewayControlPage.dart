import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_app/pages/GateFeaturesONOFF.dart';

import '../controllers/GatewayPageController.dart';


import '../items/GatewayIndicator.dart';  // Ensure this import is correct

class GatewayControlPage extends StatelessWidget {
  final GatewayPageController controller = Get.put(GatewayPageController() , permanent: false);
  bool get wantKeepAlive => true;  // Important to keep state alive


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context).copyWith(
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        buttonColor: Colors.black,
        textTheme: ButtonTextTheme.primary,
      ),
    );

    return Theme(
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gateway Control', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      var product = controller.products[index];
                      return GatewayIndicator(
                          key: ValueKey(product['id']),
                          product: product);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: [controller.first.value, controller.secound.value, controller.third.value].where((b) => b).length,
                    itemBuilder: (context, index) {
                      List<int> validIndexes = [];
                      if (controller.first.value) validIndexes.add(0);
                      if (controller.secound.value) validIndexes.add(1);
                      if (controller.third.value) validIndexes.add(2);

                      if (index >= validIndexes.length) {
                        return SizedBox(); // Return an empty widget if the index is out of range
                      }

                      var productIndex = validIndexes[index];
                      if (productIndex >= controller.products.length) {
                        return SizedBox(); // Return an empty widget if the product index is out of range
                      }

                      var product = controller.products[productIndex];
                      return _buildCustomButton(
                        context: context,
                        text: product['name'],
                        icon: Icons.door_front_door,
                        productCase: product['case'],  // Pass the case here
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (product['case'] == 'on') {
                            Get.to(() => GateFeaturesONOFF(), arguments: {'product_id': product['id'],'name':product['name']});
                          }
                        },
                      );
                    },
                  ),
                ),




              ],
            )),
          ),
        ),
      ),
    );
  }


  Widget _buildCustomButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    String? productCase, // Add this line
    VoidCallback? onPressed, // Change this line
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: productCase == 'on' ? onPressed : null, // Check the case here
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 24),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

}
