import 'package:flutter/material.dart';

class ChatRoomDetailPage extends StatelessWidget {
  const ChatRoomDetailPage({super.key});

  static const namePage = 'chat-room-details';
  @override
  Widget build(BuildContext context) {
    return const ChatRoomView();
  }
}

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Details'),
      ),
    );
  }
}
