import 'package:chat_app_mobile/common/widgets/dialogs/confirm_dialog.dart';
import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/group_request_sent/bloc/group_request_sent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupRequestSentItem extends StatelessWidget {
  const GroupRequestSentItem({
    super.key,
    required this.chatRoomId,
    required this.friendId,
    this.friendAvatar,
    this.friendName,
    this.chatRoomName,
  });

  final String chatRoomId;
  final String friendId;
  final String? friendAvatar;
  final String? friendName;
  final String? chatRoomName;

  void _handleActionCard(BuildContext ctx, String chatRoomId, String friendId) {
    ConfirmDiaglog.showConfirmDialog(
        ctx, "Confirm revoke", " Do you want to revoke the invitation?", [
      // The "Yes" button

      TextButton(
        onPressed: () {
          // Close the dialog
          Navigator.of(ctx).pop();
        },
        child: Text(
          'No',
          style: TextStyle(
            color: Theme.of(ctx).errorColor,
            fontSize: 16.sp,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          ctx.read<GroupRequestSentBloc>().add(GroupRequestSentSubmitted(
              chatRoomId: chatRoomId, friendId: friendId));
          Navigator.of(ctx).pop();
        },
        child: Text(
          'Yes',
          style: TextStyle(color: Theme.of(ctx).primaryColor, fontSize: 16.sp),
        ),
      ),
    ]);
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: RequestFriendListItem(
          avatar: friendAvatar,
          title: friendName,
          subtitleTextSpan: RichText(
            text: TextSpan(
                text: "You invited",
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: ' $friendName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp)),
                  TextSpan(
                      text: ' to the group', style: TextStyle(fontSize: 12.sp)),
                  TextSpan(
                      text: ' $chatRoomName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp)),
                ]),
          ),
          //subtitle: " $friendName to the group: $chatRoomName",
          customActionButton: IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => _handleActionCard(context, chatRoomId, friendId),
            icon: const Icon(Icons.undo),
          ),
        ),
      ),
    );
  }
}
