import 'package:chat_app_mobile/common/widgets/dialogs/confirm_dialog.dart';
import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/friends_request_sent/bloc/friend_request_sent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';

class ItemUserRequestSent extends StatelessWidget {
  const ItemUserRequestSent(
      {super.key,
      required this.uid,
      this.gender,
      this.fullname,
      this.avatar,
      this.phone,
      this.about,
      this.email});

  final String uid;
  final String? gender;
  final String? fullname;
  final String? avatar;
  final String? phone;
  final String? about;
  final String? email;

  void _handleActionCard(BuildContext ctx, String friendId) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Revoke request",
      "Do you want to revoke request friends!",
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
            ctx
                .read<FriendRequestSentBloc>()
                .add(FriendRequestCardSubmitted(id: uid));
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RequestFriendListItem(
          avatar: avatar,
          title: fullname,
          subtitle: email,
          customActionButton: IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => _handleActionCard(context, uid),
            icon: const Icon(Icons.undo),
          ),
        ),
      ),
    );
  }
}
