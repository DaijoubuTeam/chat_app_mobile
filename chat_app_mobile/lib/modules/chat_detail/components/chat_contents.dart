import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/components/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContents extends StatelessWidget {
  const ChatContents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      buildWhen: (previous, current) =>
          previous.listMessage != current.listMessage,
      builder: (context, state) {
        final listMessage = state.listMessage ?? [];
        return ListView.builder(
          itemBuilder: ((context, index) {
            return MessageItem(isMe: listMessage[index].isMe);
          }),
          itemCount: listMessage.length,
        );
      },
    );
  }
}
