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
    return Material(
      elevation: 2,
      borderRadius: isMe
          ? const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16))
          : const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topRight: Radius.circular(16)),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[500] : Colors.white,
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(16))
              : const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topRight: Radius.circular(16)),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          content ?? '',
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 15.sp,
            height: 1.5,
            //fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
