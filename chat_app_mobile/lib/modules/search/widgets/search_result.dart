import 'package:chat_app_mobile/modules/search/widgets/result_chatroom.dart';
import 'package:chat_app_mobile/modules/search/widgets/result_message.dart';
import 'package:chat_app_mobile/modules/search/widgets/result_users.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            ResultUser(),
            ResultChatRoom(),
            ResultMessage(),
          ],
        ),
      ),
    );
  }
}
