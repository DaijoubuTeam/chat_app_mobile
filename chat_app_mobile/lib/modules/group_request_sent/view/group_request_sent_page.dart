import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_request_sent/bloc/group_request_sent_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupRequestSentPage extends StatelessWidget {
  const GroupRequestSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupRequestSentBloc(
        context.read<AuthRepository>(),
        context.read<ChatRoomRepository>(),
      ),
      child: const GroupRequestSentView(),
    );
  }
}

class GroupRequestSentView extends StatelessWidget {
  const GroupRequestSentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupRequestSentBloc, GroupRequestSentState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
