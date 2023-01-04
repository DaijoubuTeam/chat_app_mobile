import 'package:chat_app_mobile/common/widgets/dialogs/confirm_dialog.dart';
import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/friends_request/bloc/friends_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';

class ItemUserRequest extends StatelessWidget {
  const ItemUserRequest(
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

  void _handleActionCard(BuildContext ctx, String id, String action) {
    if (action == "denied") {
      ConfirmDiaglog.showConfirmDialog(
        ctx,
        "Deny request",
        "Do you want to deny request friends!",
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
                  .read<FriendsRequestBloc>()
                  .add(FriendRequestCardAction(id: id, action: action));
              Navigator.of(ctx).pop();
            },
          ),
        ],
      );
    }
    if (action == "accept") {
      ctx
          .read<FriendsRequestBloc>()
          .add(FriendRequestCardAction(id: id, action: action));
    }
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
          acceptAction: () => _handleActionCard(context, uid, "accept"),
          denyAction: () => _handleActionCard(context, uid, "denied"),
        ),
      ),
    );
  }
}
