import 'package:flutter/material.dart';

class GatewayIndicator extends StatelessWidget {
  final Map<String, dynamic> product;
  var key;

  GatewayIndicator({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool status = product['case'] == "on";
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: status ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: status ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            status ? Icons.wifi : Icons.wifi_off,
            color: status ? Colors.green : Colors.red,
            size: 24,
          ),
          SizedBox(width: 10),
          Text(
            "${product['name']} Gateway: ${status ? "On" : "Off"}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
