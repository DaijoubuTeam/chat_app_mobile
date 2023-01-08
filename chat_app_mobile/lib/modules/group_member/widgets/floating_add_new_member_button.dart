import 'package:chat_app_mobile/modules/group_add_new_member/view/group_add_new_member.dart';
import 'package:chat_app_mobile/modules/group_member/bloc/group_member_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FloatingAddNewMemberButton extends StatelessWidget {
  const FloatingAddNewMemberButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMemberBloc, GroupMemberState>(
      builder: (context, state) {
        return FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () {
            context.pushNamed(GroupAddNewMemberPage.namePage,
                params: {"chatRoomId": state.chatRoomId},
                extra: {"chatRoomMember": state.members});
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
