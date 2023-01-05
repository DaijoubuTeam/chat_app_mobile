import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/dialogs/confirm_dialog.dart';
import '../../group_edit/view/view.dart';
import '../../group_member/view/group_member_page.dart';

class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context) {
    void handleEditGroup(BuildContext ctx, String groupId) async {
      await Navigator.of(ctx)
          .push(MaterialPageRoute(
              builder: (ctx) => GroupEditPage(groupId: groupId)))
          .then((_) {
        ctx.read<ChatRoomDetailBloc>().add(ChatRoomDetailInited());
      });
    }

    void handleManageMember(BuildContext ctx, ChatRoom chatRoom) async {
      await Navigator.of(ctx)
          .push(MaterialPageRoute(
              builder: (ctx) => GroupMemberPage(chatRoomInfor: chatRoom)))
          .then((_) {
        ctx.read<ChatRoomDetailBloc>().add(ChatRoomDetailInited());
      });
    }

    void handleDeleteGroup(BuildContext ctx) {
      ConfirmDiaglog.showConfirmDialog(
        ctx,
        "Confirm delete group",
        "Do you want to delete your group?",
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
              ctx.read<ChatRoomDetailBloc>().add(ChatRoomDetailGroupRemoved());
            },
          ),
        ],
      );
    }

    void handleLeaveGroup(BuildContext ctx) {
      ConfirmDiaglog.showConfirmDialog(
        ctx,
        "Confirm leave group",
        "Do you want to leave your group?",
        [
          // The "Yes" button
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
              ctx.read<ChatRoomDetailBloc>().add(ChatRoomDetailGroupLeft());
            },
          ),
        ],
      );
    }

    return BlocBuilder<ChatRoomDetailBloc, ChatRoomDetailState>(
      builder: (context, state) {
        final groupChatRoomInfor =
            (state as ChatRoomDetailGetDataSuccess).chatRoomInformation;
        return Column(
          children: <Widget>[
            if (groupChatRoomInfor!.isAdmin)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  title: Text(
                    'Edit Group',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  onTap: () => handleEditGroup(context, state.chatRoomId),
                ),
              ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.group_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  'See members (${state.chatRoomInformation!.members.length})',
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () {
                  handleManageMember(
                    context,
                    state.chatRoomInformation!,
                  );
                },
              ),
            ),
            if (!groupChatRoomInfor.isAdmin)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  iconColor: Colors.red[400],
                  textColor: Colors.red[400],
                  trailing: const Icon(Icons.logout),
                  title: const Text(
                    'Leave',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => handleLeaveGroup(context),
                ),
              ),
            if (groupChatRoomInfor.isAdmin)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red[400],
                      )
                    ],
                  ),
                  iconColor: Colors.red[400],
                  textColor: Colors.red[400],
                  title: const Text(
                    'Remove group',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => handleDeleteGroup(context),
                ),
              ),
          ],
        );
      },
    );
  }
}
