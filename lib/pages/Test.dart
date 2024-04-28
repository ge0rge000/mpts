import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class TimeController extends GetxController {
  late IOWebSocketChannel channel;
  var texttt = ''.obs;
  RxString myText = 'Initial'.obs;

  void updateText(String newText) {
    myText.value = newText;  // Correct way to update RxString
  }


  TimeController() {
     channel = IOWebSocketChannel.connect('ws://gpio.mpts-me.com/app/local');
    channel.sink.add(
      jsonEncode(
        {
          "event": "pusher:subscribe",
          "data": {
            "channel": "public"
          }
        },
      ),
    );

    /// Listen for all incoming data
     channel.stream.listen((data) {
       print(data);  // Print the raw data received

       // Assuming 'data' is already a JSON-decoded Map
       if (data is String) {
         // Parse the initial JSON string if necessary
         data = json.decode(data);
       }

       if (data['data'] is String) {
         // Parse the nested JSON string in 'data'
         Map<String, dynamic> nestedData = json.decode(data['data']);

         // Correctly updating RxString
         texttt.value = nestedData['data'];
       }
     });

  }


  @override
  void onClose() {
    print('Debug - Closing channel');  // Debug print
    channel.sink.close();
    super.onClose();
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimeController controller = Get.put(TimeController());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Real-Time Server Clock')),
        body: Center(
          child: Obx(() => Text(
            controller.texttt.value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
