import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/view/call_page.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_app_bar_title.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_box.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/list_message.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/view/view.dart';
import 'package:chat_app_mobile/utils/hide_keyboard.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:go_router/go_router.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({
    super.key,
    required this.chatRoomId,
    this.messageId,
  });

  static const String namePage = 'chat-details';

  final String chatRoomId;
  final String? messageId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailBloc(
        chatRoomId: chatRoomId,
        messageId: messageId,
        chatRoomRepository: context.read<ChatRoomRepository>(),
        authRepository: context.read<AuthRepository>(),
        messageRepository: context.read<MessageRepository>(),
      ),
      child: ChatDetailView(
        chatRoomId: chatRoomId,
        messageId: messageId,
      ),
    );
  }
}

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({
    Key? key,
    required this.chatRoomId,
    this.messageId,
  }) : super(key: key);

  final String chatRoomId;
  final String? messageId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const ChatAppBarTitle(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            actions: [
              if (state.chatRoomInfo?.type == "personal")
                IconButton(
                  onPressed: () async {
                    context.pushNamed(
                      CallPage.namePage,
                      extra: {
                        "friendId":
                            state.chatRoomInfo?.friendsInChatRoom.first.uid,
                        "isReceiver": false,
                      },
                    );
                  },
                  icon: const Icon(Icons.call),
                ),
              IconButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (ctx) =>
                              ChatRoomDetailPage(chatRoomId: chatRoomId)))
                      .then((_) {
                    context
                        .read<ChatDetailBloc>()
                        .add(const ChatDetailPageInited());
                  });
                },
                icon: const Icon(Icons.more_vert),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    SettingsKeyboard.hideKeyBoard(context),
                    context
                        .read<ChatDetailBloc>()
                        .add(const ChatDetailShowOptionChanged()),
                  },
                  child: ChatContents(
                    messageId: messageId,
                  ),
                ),
              ),
              const ChatBox(),
            ],
          ),
        );
      },
    );
  }
}
