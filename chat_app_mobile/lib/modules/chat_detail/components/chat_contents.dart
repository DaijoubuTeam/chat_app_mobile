import 'package:chat_app_mobile/modules/chat_detail/components/message_item.dart';
import 'package:flutter/material.dart';

class ChatContents extends StatelessWidget {
  const ChatContents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return MessageItem(indexMessage: index);
      }),
      itemCount: 100,
    );
  }
}
