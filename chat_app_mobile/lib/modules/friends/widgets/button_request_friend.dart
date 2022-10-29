import 'package:chat_app_mobile/modules/friends_request/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonRequestFriend extends StatelessWidget {
  const ButtonRequestFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        title: const Text('Friends Request'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.pushNamed(FriendsRequestPage.namePage);
        },
      ),
    );
  }
}
