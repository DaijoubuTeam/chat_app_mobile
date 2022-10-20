import 'package:flutter/material.dart';

class ChatItems extends StatelessWidget {
  const ChatItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Nguyen Van A'),
          subtitle: const Text('Nguyen Van A'),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const <Widget>[
                Text('Thurs'),
                Text('Thurs'),
              ],
            ),
          ),
        );
      }),
      itemCount: 5,
    );
  }
}
