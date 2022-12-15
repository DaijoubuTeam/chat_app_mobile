import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmojiMessageItem extends IMessageItem {
  const EmojiMessageItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 48.sp,
      ),
    );
  }
}
