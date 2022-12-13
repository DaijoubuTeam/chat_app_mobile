import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/modules/call_page/widgets/video_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CallContainer extends StatelessWidget {
  const CallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallBloc, CallState>(
      listener: (context, state) {},
      child: const VideosContainer(),
    );
  }
}
