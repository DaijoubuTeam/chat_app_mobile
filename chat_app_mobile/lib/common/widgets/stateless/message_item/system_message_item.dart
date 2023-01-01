import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemMessageItem extends IMessageItem {
  const SystemMessageItem({
    super.key,
    this.content,
    this.nameActor,
  });

  final String? content;
  final String? nameActor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300]?.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400]!)),
      child: Text(
        '${nameActor ?? ''} ${convertSystemString(content ?? '')}',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          //fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  String convertSystemString(String content) {
    switch (content) {
      case "createRoom":
        {
          return "created room";
        }
      case "joinRoom":
        {
          return "joined room";
        }
      case "becomeFriend":
        {
          return "and you became friends";
        }
      case "removedFromRoom":
        {
          return "were removed";
        }
      default:
        {
          return content;
        }
    }
  }
}
