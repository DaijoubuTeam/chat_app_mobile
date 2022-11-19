import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContentButtonSend extends StatelessWidget {
  const ChatContentButtonSend({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ChatDetailBloc>().add(ChatDetailContentSubmitted());
      },
      icon: Icon(
        Icons.send,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
