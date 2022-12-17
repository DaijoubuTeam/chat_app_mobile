import 'package:chat_app_mobile/modules/group_edit/view/group_edit_page.dart';
import 'package:chat_app_mobile/modules/group_list/bloc/group_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

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
    ctx.read<GroupListBloc>().add(GroupListGroupDeleted(idChatRoom: groupId));
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
          onPressed: (context) => _handleDeleteGroupChatItem(context, groupId),
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
          onPressed: (ctx) => {
            ctx
                .read<GroupListBloc>()
                .add(GroupListGroupLeft(idChatRoom: groupId)),
          },
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
        } else if (state.status == FormzStatus.submissionCanceled) {
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
        } else {
          return const Center(
            child: Text("Somethings wrongs"),
          );
        }
      },
    );
  }
}
