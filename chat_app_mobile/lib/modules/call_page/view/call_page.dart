import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.friendId});

  static const namePage = "call-page";
  final String friendId;

  @override
  Widget build(BuildContext context) {
    return CallView(
      friendId: friendId,
    );
  }
}

class CallView extends StatelessWidget {
  const CallView({super.key, required this.friendId});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendId),
      ),
      body: VideosContainer(
        friendId: friendId,
      ),
    );
  }
}
