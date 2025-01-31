import 'package:flutter/material.dart';
import 'package:web_socket_flutter/noti_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotiService.showNotification(
              title: "Title",
              body: "Body",
            );
          },
          child: const Text("Send Notification"),
        ),
      ),
    );
  }
}
