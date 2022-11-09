import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.isMe}) : super(key: key);

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
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
              color: isMe
                  ? Theme.of(context).primaryColor
                  : Colors.grey[800]?.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Chat Text',
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
