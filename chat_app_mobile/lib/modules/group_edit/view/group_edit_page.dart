import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
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
      child: const GroupEditView(),
    );
  }
}

class GroupEditView extends StatelessWidget {
  const GroupEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
      builder: (context, state) {
        if (state is GroupEditInitial) {
          return Scaffold(
            appBar: AppBarCustom(
              title: state.groupId,
            ),
          );
        }
        return Scaffold(
          appBar: AppBarCustom(
            title: state.groupId,
          ),
          body: Container(),
        );
      },
    );
  }
}
