import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            isReceiver: false,
            authRepository: context.read<AuthRepository>(),
          );
        }
        return CallBloc.invited(
          friendId: friendId,
          isReceiver: true,
          authRepository: context.read<AuthRepository>(),
        );
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
        // return Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.black,
        //     automaticallyImplyLeading: false,
        //     systemOverlayStyle: const SystemUiOverlayStyle(
        //       // Status bar color
        //       statusBarColor: Colors.black,

        //       // // Status bar brightness (optional)
        //       // statusBarIconBrightness:
        //       //     Brightness.dark, // For Android (dark icons)
        //       // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        //     ),
        //   ),
        //   body: const VideosContainer(),
        // );
        return AnnotatedRegion<SystemUiOverlayStyle>(
            //Set status bar icon color
            value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
            ),
            child: const VideosContainer());
      },
    );
  }
}
