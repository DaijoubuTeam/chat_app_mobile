import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_add_new_member/widgets/list_new_member.dart';
import 'package:chat_app_mobile/modules/group_add_new_member/widgets/search_new_member.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

import '../bloc/group_add_new_member_bloc.dart';

class GroupAddNewMemberPage extends StatelessWidget {
  const GroupAddNewMemberPage({
    Key? key,
    required this.chatRoomId,
    required this.members,
  }) : super(key: key);

  static const namePage = 'groupAddNewMemberPage';

  final String chatRoomId;
  final List<chat_room_repo.User> members;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupAddNewMemberBloc(
        chatRoomId,
        members,
        context.read<AuthRepository>(),
        context.read<FriendRepository>(),
        context.read<ChatRoomRepository>(),
      ),
      child: const GroupAddNewMemberView(),
    );
  }
}

class GroupAddNewMemberView extends StatelessWidget {
  const GroupAddNewMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite new member"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context
                  .read<GroupAddNewMemberBloc>()
                  .add(GroupAddNewMemberButtonSubmitted());
            },
            child: const Text("Done"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          children: <Widget>[
            const ListNewMember(),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: SearchNewMember(),
            ),
          ],
        ),
      ),
    );
  }
}
