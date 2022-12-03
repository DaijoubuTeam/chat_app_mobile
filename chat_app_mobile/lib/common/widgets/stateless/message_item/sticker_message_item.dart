import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';

class StickerMessageItem extends IMessageItem {
  const StickerMessageItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/$content.gif',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}
