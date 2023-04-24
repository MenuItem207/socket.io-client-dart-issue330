import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Socket socket = io(
              'http://localhost:3000',
              OptionBuilder()
                  .setTransports(['websocket'])
                  .enableForceNewConnection()
                  .disableAutoConnect()
                  .disableReconnection() // don't try to reconnect
                  .setTimeout(5000) // milliseconds
                  .build(),
            );
            socket.connect();
            socket.onConnect((data) {
              print('connected!');
              socket.emitWithAck('test_buffer', null, ack: (data) {
                print('Received ack $data');
              });
            });
          },
          child: const Text(
            'click me :)',
            style: TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }
}
