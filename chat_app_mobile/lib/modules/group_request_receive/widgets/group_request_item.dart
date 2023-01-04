import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/group_request_receive/bloc/group_request_receive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/dialogs/confirm_dialog.dart';

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
    if (type == "reject") {
      ConfirmDiaglog.showConfirmDialog(
        ctx,
        "Confirm reject",
        " Do you want to reject the invitation?",
        [
          DeniedButton(
            handleClick: () {
              // Close the dialog
              Navigator.of(ctx).pop();
            },
          ),
          SizedBox(
            width: 16.sp,
          ),
          AcceptButton(
            handleClick: () {
              ctx.read<GroupRequestReceiveBloc>().add(
                  GroupRequestActionSubmitted(
                      chatRoomId: chatRoomId, type: "reject"));
              Navigator.of(ctx).pop();
            },
          ),
        ],
      );
    }
    if (type == "accept") {
      ctx.read<GroupRequestReceiveBloc>().add(
          GroupRequestActionSubmitted(chatRoomId: chatRoomId, type: "accept"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RequestFriendListItem(
          avatar: chatRoomAvatar,
          title: chatRoomName,
          subtitleTextSpan: RichText(
            text: TextSpan(
                text: "You have received an invitation to join the group: ",
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: ' $chatRoomName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp)),
                ]),
          ),
          acceptAction: () => _handleActionCard(context, chatRoomId, "accept"),
          denyAction: () => _handleActionCard(context, chatRoomId, "reject"),
        ),
      ),
    );
  }
}
