import 'dart:developer';

import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContents extends StatefulWidget {
  const ChatContents({super.key});

  @override
  State<ChatContents> createState() => _ChatContentsState();
}

class _ChatContentsState extends State<ChatContents> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent - 20 == controller.offset - 20) {
        if (mounted) {
          context.read<ChatDetailBloc>().add(ChatDetailListMessageLoadMore());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      // buildWhen: (previous, current) =>
      //     previous.listMessage.length != current.listMessage.length,
      builder: (context, state) {
        final listMessage = state.displayListMessage ?? [];
        return ListView.builder(
          controller: controller,
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
