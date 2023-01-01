import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

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
            isReceiver: false,
            authRepository: context.read<AuthRepository>(),
            webRTCRepostiory: context.read<WebRTCRepostiory>(),
          );
        }
        return CallBloc.invited(
            friendId: friendId,
            isReceiver: true,
            authRepository: context.read<AuthRepository>(),
            webRTCRepostiory: context.read<WebRTCRepostiory>());
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
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          // child: AnnotatedRegion<SystemUiOverlayStyle>(
          //     //Set status bar icon color
          //     value: SystemUiOverlayStyle.dark.copyWith(
          //       statusBarColor: Colors.transparent,
          //       statusBarIconBrightness: Brightness.dark,
          //     ),
          //     child: const VideosContainer()),
          child: const Scaffold(
            body: VideosContainer(),
          ),
        );
      },
    );
  }
}
