import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/dialogs/confirm_dialog.dart';

class FriendDetail extends StatelessWidget {
  const FriendDetail({super.key});

  void _handleDeleteFriend(BuildContext ctx, String friendId) => {
        ConfirmDiaglog.showConfirmDialog(
          ctx,
          "Confirm delete friend",
          "Do you want to delete your friend?",
          [
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
                ctx
                    .read<ChatRoomDetailBloc>()
                    .add(ChatRoomDetailFriendDeleted(friendId: friendId));
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    color: Theme.of(ctx).primaryColor, fontSize: 16.sp),
              ),
            ),
          ],
        )
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomDetailBloc, ChatRoomDetailState>(
      buildWhen: (previous, current) =>
          previous != current &&
          current.runtimeType == ChatRoomDetailGetDataSuccess,
      builder: (context, state) {
        final friendInChatRoom = (state as ChatRoomDetailGetDataSuccess)
            .chatRoomInformation
            ?.friendsInChatRoom
            .toList();
        return Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.remove_circle_outline_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
                minLeadingWidth: 16,
                title: Text(
                  'Delete Friend',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                ),
                onTap: () =>
                    _handleDeleteFriend(context, friendInChatRoom![0].uid),
              ),
            ),
          ],
        );
      },
    );
  }
}
