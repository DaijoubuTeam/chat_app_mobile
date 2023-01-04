import 'package:chat_app_mobile/common/widgets/dialogs/confirm_dialog.dart';
import 'package:chat_app_mobile/modules/group_edit/view/group_edit_page.dart';
import 'package:chat_app_mobile/modules/group_list/bloc/group_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/stateless/list_title/person_list_item.dart';
import '../../chat_detail/view/view.dart';

class ListGroupJoined extends StatelessWidget {
  const ListGroupJoined({super.key});

  void _handleTapGroupChatItem(
    BuildContext ctx,
    String? chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
  ) {
    if (chatRoomId == null) return;
    ctx.pushNamed(
      ChatDetailPage.namePage,
      params: {'chatRoomId': chatRoomId},
    );
  }

  void _handleDeleteGroupChatItem(BuildContext ctx, String groupId) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Confirm delete group",
      "Do you want to delete group?",
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
                .read<GroupListBloc>()
                .add(GroupListGroupDeleted(idChatRoom: groupId));
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }

  void _handleLeaveGroupChat(BuildContext ctx, String groupId) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Confirm leave group",
      "Do you want to leave group?",
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
                .read<GroupListBloc>()
                .add(GroupListGroupLeft(idChatRoom: groupId));
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }

  ActionPane _buildEndActionPane(BuildContext ctx, String groupId) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          onPressed: (ctx) => {
            ctx.pushNamed(
              GroupEditPage.namePage,
              params: {
                "groupId": groupId,
              },
            ),
          },
          backgroundColor: Theme.of(ctx).primaryColor,
          foregroundColor: Colors.white,
          icon: Icons.archive,
          label: 'Edit',
        ),
        SlidableAction(
          onPressed: (_) => _handleDeleteGroupChatItem(ctx, groupId),
          backgroundColor: Colors.red[400]!,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    );
  }

  ActionPane _buildEndActionLeaveGroup(BuildContext ctx, String groupId) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          onPressed: (ctx) => _handleLeaveGroupChat(ctx, groupId),
          backgroundColor: Colors.red[400]!,
          foregroundColor: Colors.white,
          icon: Icons.login_outlined,
          label: 'Leave',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == FormzStatus.submissionSuccess) {
          final listGroup = state.listChatRoom!;
          if (listGroup.isEmpty) {
            return const Center(
              child: Text("No groups"),
            );
          }
          return ListView.builder(
            itemBuilder: ((context, index) {
              return PersonListItem(
                key: ValueKey(state.listChatRoom![index].chatRoomId),
                title: state.listChatRoom![index].chatRoomName,
                avatar: state.listChatRoom![index].chatRoomAvatar,
                isAdmin: state.listChatRoom![index].isAdmin,
                endActionPane: state.listChatRoom![index].isAdmin
                    ? _buildEndActionPane(
                        context,
                        state.listChatRoom![index].chatRoomId,
                      )
                    : _buildEndActionLeaveGroup(
                        context,
                        state.listChatRoom![index].chatRoomId,
                      ),
                handleOnTab: () => _handleTapGroupChatItem(
                  context,
                  state.listChatRoom![index].chatRoomId,
                  state.listChatRoom![index].chatRoomName,
                  state.listChatRoom![index].chatRoomAvatar,
                ),
              );
            }),
            itemCount: state.listChatRoom!.length,
          );
        } else if (state.status == FormzStatus.submissionCanceled) {
          return const Center(
            child: Text("Somethings wrongs"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
