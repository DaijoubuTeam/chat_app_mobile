import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.indexMessage}) : super(key: key);

  final int indexMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: indexMessage % 2 == 0
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (indexMessage % 2 == 0) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage("https://picsum.photos/200/300"),
            ),
            const SizedBox(
              width: 8,
            )
          ],
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16 * 0.75,
              vertical: 16 / 2,
            ),
            decoration: BoxDecoration(
              color: indexMessage % 2 == 0
                  ? Colors.grey[800]?.withOpacity(0.1)
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Chat Text',
              style: TextStyle(
                  color: indexMessage % 2 == 0 ? Colors.black : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
