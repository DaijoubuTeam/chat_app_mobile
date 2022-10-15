import 'package:flutter/material.dart';

import '../widgets/find_friend_form.dart';

class FriendsRequestPage extends StatelessWidget {
  static String namePage = 'friends-request';
  const FriendsRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends Request'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            context: context,
            isScrollControlled: true,
            builder: ((context) {
              return const Padding(
                padding: EdgeInsets.all(32.0),
                child: FindFriendForm(),
              );
            }),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
