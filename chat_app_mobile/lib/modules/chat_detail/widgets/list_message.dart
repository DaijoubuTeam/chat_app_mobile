import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContents extends StatelessWidget {
  const ChatContents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      // buildWhen: (previous, current) =>
      //     previous.listMessage.length != current.listMessage.length,
      builder: (context, state) {
        final listMessage = state.listMessage ?? [];
        return ListView.builder(
          reverse: true,
          itemBuilder: ((context, index) {
            return MessageItem(
              isMe: listMessage[index].isMe ?? false,
              content: listMessage[index].content!,
              friendAvatar: listMessage[index].from?.avatar,
              readed: listMessage[index].readed?.toList(),
              type: listMessage[index].type,
            );
          }),
          itemCount: listMessage.length,
        );
      },
    );
  }
}
