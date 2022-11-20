import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/chat_detail/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
    this.latestMessage,
    this.time,
  });

  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;
  final String? latestMessage;
  final DateTime? time;

  void _handleTapChatRoomItem(BuildContext ctx) {
    ctx.pushNamed(
      ChatDetailPage.namePage,
      params: {'chatRoomId': chatRoomId},
      extra: {
        'chatRoomName': chatRoomName,
        'chatRoomAvatar': chatRoomAvatar,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersonListItem(
      handleOnTab: () => _handleTapChatRoomItem(context),
      isShowPoint: true,
      isOnline: true,
      avatar: chatRoomAvatar,
      title: chatRoomName,
      subTitle: latestMessage,
      time: time,
    );
  }
}
