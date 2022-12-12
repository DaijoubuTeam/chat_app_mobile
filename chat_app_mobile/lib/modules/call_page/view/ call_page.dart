import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  static const namePage = "call-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CallPage"),
      ),
    );
  }
}
