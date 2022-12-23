import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/group_member/bloc/group_member_bloc.dart';
import 'package:chat_app_mobile/modules/group_member/widgets/floating_add_new_member_button.dart';
import 'package:chat_app_mobile/modules/group_member/widgets/group_member_list.dart';
import 'package:flutter/material.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupMemberPage extends StatelessWidget {
  const GroupMemberPage({
    Key? key,
    this.chatRoomInfor,
  }) : super(key: key);

  static const String namePage = "group-member";

  final chat_room_repo.ChatRoom? chatRoomInfor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupMemberBloc(
          chatRoomInfor,
          context.read<AuthRepository>(),
          context.read<chat_room_repo.ChatRoomRepository>()),
      child: const GroupMemberView(),
    );
  }
}

class GroupMemberView extends StatelessWidget {
  const GroupMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMemberBloc, GroupMemberState>(
        builder: (context, state) {
      return Scaffold(
        appBar: const AppBarCustom(
          title: "Group member",
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                //controller: _inputController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search your friends",
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Expanded(child: GroupMemberList()),
          ],
        ),
        floatingActionButton:
            state.isAdmin ? const FloatingAddNewMemberButton() : null,
      );
    });
  }
}
