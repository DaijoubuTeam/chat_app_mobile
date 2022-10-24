import 'package:chat_app_mobile/modules/chat_detail/components/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_mobile/modules/chat_detail/components/chat_app_bar_title.dart';
import 'package:chat_app_mobile/modules/chat_detail/components/chat_contents.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  static const String namePage = 'chat-details';

  @override
  Widget build(BuildContext context) {
    return const ChatDetailView();
  }
}

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ChatAppBarTitle(),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ChatContents(),
            ),
          ),
          ChatBox(),
        ],
      ),
    );
  }
}
