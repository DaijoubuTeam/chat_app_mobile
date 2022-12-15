import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/friends_request/bloc/friends_request_bloc.dart';
import 'package:chat_app_mobile/modules/group_request_receive/bloc/group_request_receive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupRequestItem extends StatelessWidget {
  const GroupRequestItem({
    super.key,
    required this.chatRoomId,
    this.chatRoomAvatar,
    this.chatRoomName,
  });

  final String chatRoomId;
  final String? chatRoomAvatar;
  final String? chatRoomName;

  void _handleActionCard(BuildContext ctx, String chatRoomId, String type) {
    ctx
        .read<GroupRequestReceiveBloc>()
        .add(GroupRequestActionSubmitted(chatRoomId: chatRoomId, type: type));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RequestFriendListItem(
          avatar: chatRoomAvatar,
          title: chatRoomName,
          acceptAction: () => _handleActionCard(context, chatRoomId, "accept"),
          denyAction: () => _handleActionCard(context, chatRoomId, "denied"),
        ),
      ),
    );
  }
}
