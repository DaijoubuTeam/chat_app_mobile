import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StickerMessageItem extends IMessageItem {
  const StickerMessageItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/stickers/$content.gif',
      width: 148.w,
      height: 148.h,
      fit: BoxFit.cover,
    );
  }
}
