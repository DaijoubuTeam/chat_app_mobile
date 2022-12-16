import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_edit/bloc/group_edit_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupEditPage extends StatelessWidget {
  const GroupEditPage({
    super.key,
    required this.groupId,
  });

  static const namePage = "group-edit-page";
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupEditBloc(
          authRepository: context.read<AuthRepository>(),
          chatRoomRepository: context.read<ChatRoomRepository>(),
          groupId: groupId),
      child: Container(),
    );
  }
}

class GroupEditView extends StatelessWidget {
  const GroupEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Group edit"),
          ),
        );
      },
    );
  }
}
