import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  static const namePage = "call-page";

  @override
  Widget build(BuildContext context) {
    return const CallView();
  }
}

class CallView extends StatelessWidget {
  const CallView({super.key});

  static const namePage = "call-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CallPage"),
      ),
      body: const VideosContainer(),
    );
  }
}
