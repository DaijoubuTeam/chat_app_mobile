import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_app_bar_title.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_box.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/list_message.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/view/view.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:message_repository/message_repository.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key, required this.chatRoomId});

  static const String namePage = 'chat-details';

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailBloc(
        chatRoomId: chatRoomId,
        chatRoomRepository: context.read<ChatRoomRepository>(),
        authRepository: context.read<AuthRepository>(),
        messageRepository: context.read<MessageRepository>(),
      ),
      child: ChatDetailView(chatRoomId: chatRoomId),
    );
  }
}

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({Key? key, required this.chatRoomId}) : super(key: key);

  final String chatRoomId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ChatAppBarTitle(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => {
              context.pushNamed(
                ChatRoomDetailPage.namePage,
                params: {
                  'chatRoomId': chatRoomId,
                },
              ),
            },
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ChatContents(),
            ),
          ),
          ChatBox(),
        ],
      ),
    );
  }
}
