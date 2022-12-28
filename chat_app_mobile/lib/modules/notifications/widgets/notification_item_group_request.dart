import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationItemGroupRequest extends StatelessWidget {
  const NotificationItemGroupRequest(
      {Key? key, this.fullname, this.avatar, this.subtitle, this.idSender})
      : super(key: key);

  final String? fullname;
  final String? avatar;
  final String? subtitle;
  final String? idSender;

  void _handleAcceptRequest(BuildContext ctx) {
    if (idSender == null) {
      return;
    }
    ctx.read<NotificationBloc>().add(NotificationRequestSubmitted(
        typeAction: "accept", idSender: idSender!));
  }

  void _handleDeniedRequest(BuildContext ctx) {
    if (idSender == null) {
      return;
    }
    ctx.read<NotificationBloc>().add(NotificationRequestSubmitted(
        typeAction: "denied", idSender: idSender!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: RequestFriendListItem(
        acceptAction:
            subtitle != null ? () => _handleAcceptRequest(context) : null,
        denyAction:
            subtitle != null ? () => _handleDeniedRequest(context) : null,
        avatar: avatar,
        title: fullname ?? '',
        subtitle: "invited you to join group: $subtitle",
      ),
    );
  }
}
