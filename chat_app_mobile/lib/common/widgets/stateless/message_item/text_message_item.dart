import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMessageItem extends IMessageItem {
  const TextMessageItem({
    super.key,
    this.content,
    this.isMe = false,
  });

  final String? content;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).primaryColor
            : Colors.grey[800]?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        content ?? '',
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
