import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_request_receive/bloc/group_request_receive_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class GroupRequestReceivePage extends StatelessWidget {
  const GroupRequestReceivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupRequestReceiveBloc(
        context.read<AuthRepository>(),
        context.read<ChatRoomRepository>(),
      ),
      child: const GroupRequestReceiveView(),
    );
  }
}

class GroupRequestReceiveView extends StatelessWidget {
  const GroupRequestReceiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupRequestReceiveBloc, GroupRequestReceiveState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == FormzStatus.submissionSuccess) {
          if (state.listGroupRequestReceived!.isEmpty) {
            return const Center(
              child: Text("No request now!"),
            );
          } else {
            return Center(
              child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Text(
                        state.listGroupRequestReceived![index].chatRoomName ??
                            '');
                  }),
                  itemCount: state.listGroupRequestReceived!.length),
            );
          }
        } else {
          return const Center(
            child: Text("Something wrong!"),
          );
        }
      },
    );
  }
}
