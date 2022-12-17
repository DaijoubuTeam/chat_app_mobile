import 'package:flutter/material.dart';

class ButtonAddNewFriend extends StatelessWidget {
  const ButtonAddNewFriend({super.key});

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
        title: const Text('Add new friend'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // context.pushNamed(FriendsRequestPage.namePage);
        },
      ),
    );
  }
}
