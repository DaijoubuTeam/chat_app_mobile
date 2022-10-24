import 'package:chat_app_mobile/modules/friends_request/widgets/find_friend_button.dart';
import 'package:chat_app_mobile/modules/friends_request/widgets/find_friend_input.dart';
import 'package:flutter/material.dart';

class FindFriendForm extends StatelessWidget {
  const FindFriendForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 32,
          left: 32,
          right: 32,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          FindFriendInput(),
          SizedBox(
            height: 8,
          ),
          FindFriendButton()
        ],
      ),
    );
  }
}
