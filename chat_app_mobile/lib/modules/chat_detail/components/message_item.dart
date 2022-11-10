import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(
      {Key? key, required this.isMe, required this.content, this.friendAvatar})
      : super(key: key);

  final bool isMe;
  final String content;
  final String? friendAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: (friendAvatar != null)
                  ? NetworkImage(friendAvatar!)
                  : const AssetImage("assets/images/empty_avatar.png")
                      as ImageProvider,
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
              content,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
