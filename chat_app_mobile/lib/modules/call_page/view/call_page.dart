import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/modules/call_page/widgets/call_container.dart';
import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallPage extends StatelessWidget {
  const CallPage({
    super.key,
    required this.friendId,
    this.isReceiver = false,
  });

  static const namePage = "call-page";
  final String friendId;
  final bool isReceiver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        if (!isReceiver) {
          return CallBloc(
            friendId: friendId,
            authRepository: context.read<AuthRepository>(),
          );
        }
        return CallBloc.invited(
            friendId: friendId, authRepository: context.read<AuthRepository>());
      },
      child: const CallView(),
    );
  }
}

class CallView extends StatelessWidget {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.friendId),
          ),
          body: const VideosContainer(),
        );
      },
    );
  }
}
