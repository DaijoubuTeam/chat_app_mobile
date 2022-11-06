import 'package:chat_app_mobile/modules/friends/widgets/list_friend.dart';
import 'package:flutter/material.dart';

import '../widgets/button_request_friend.dart';

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FriendsView();
  }
}

class FriendsView extends StatelessWidget {
  const FriendsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const ButtonRequestFriend(),
          Divider(
            height: 25,
            color: Colors.grey[100],
            thickness: 16,
          ),
          const Expanded(child: ListFriend()),
        ],
      ),
    );
  }
}
