import 'package:flutter/material.dart';

class ButtonRequestGroup extends StatelessWidget {
  const ButtonRequestGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.group,
            color: Colors.white,
          ),
        ),
        title: const Text('Groups Request'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
