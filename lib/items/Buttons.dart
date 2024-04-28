import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remote_app/controllers/FeatureController.dart';

class Buttons_on_off extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(context, 'Open', Icons.lock_open, Colors.green, '0'),
          SizedBox(width: 20),
          _buildActionButton(context, 'Lock', Icons.lock, Colors.red, '1'),
        ],
      ),
    );
  }
}



Widget _buildActionButton(BuildContext context, String text, IconData icon, Color color, String command) {
  final FeatureController controller = Get.put(FeatureController());
  final Map<String, dynamic> args = Get.arguments;

  final int productId = int.tryParse(args['product_id'].toString()) ?? 0;
  return Expanded(
    child: ElevatedButton.icon(
      onPressed: () {
        print(productId);
        controller.openCloseCommand(productId,command);

      } ,
      icon: Icon(icon, size: 20),
      label: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        shadowColor: Colors.black45,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // More rounded corners
        ),
        padding: EdgeInsets.symmetric(vertical: 16), // More padding for a taller button
        textStyle: TextStyle(fontSize: 16),
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return color.withOpacity(0.85); // Slightly darken the color when the button is pressed
            return color; // Use the default color
          },
        ),
      ),
    ),
  );
}
