import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_content_button_send.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_content_input.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 32,
          color: Theme.of(context).primaryColor.withOpacity(0.08),
        ),
      ]),
      child: SafeArea(
        child: Row(
          children: const <Widget>[
            ChatContentInput(),
            SizedBox(
              width: 16,
            ),
            ChatContentButtonSend(),
          ],
        ),
      ),
    );
  }
}
