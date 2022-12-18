import 'package:flutter/material.dart';

import '../../find_friend/view/view.dart';

class ButtonAddNewFriend extends StatelessWidget {
  const ButtonAddNewFriend({super.key});

  void _buildModalBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      context: ctx,
      isScrollControlled: true,
      builder: ((ctx) => const FindFriendPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.person_add_outlined,
            color: Colors.white,
          ),
        ),
        title: const Text('Add new friend'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _buildModalBottomSheet(context),
      ),
    );
  }
}
