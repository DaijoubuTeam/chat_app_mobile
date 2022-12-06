import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/home_app_bar.dart';
import 'package:chat_app_mobile/modules/chat/bloc/chat_bloc.dart';
import 'package:chat_app_mobile/modules/chat/widgets/chat_item.dart';
import 'package:chat_app_mobile/modules/chat/widgets/chat_place_holder.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        context.read<AuthRepository>(),
        context.read<ChatRoomRepository>(),
      ),
      child: const ChatView(),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBarCustom(),
      body: Container(
        color: Colors.white,
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.runtimeType == ChatGetListSuccess) {
              final listChatRoom = (state as ChatGetListSuccess).listChatRoom;
              if (listChatRoom.isEmpty) {
                return const Center(child: ChatPlaceHolder());
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ChatBloc>().add(ChatPageInited());
                },
                child: Scrollbar(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      //reverse: true,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return ChatItem(
                          chatRoomId: listChatRoom[index].chatRoomId,
                          chatRoomName: listChatRoom[index].chatRoomName,
                          chatRoomAvatar: listChatRoom[index].chatRoomAvatar,
                          latestMessage:
                              listChatRoom[index].latestMessage?.content ?? '',
                          time: listChatRoom[index].latestMessage?.createdAt,
                        );
                      }),
                      itemCount: listChatRoom.length,
                    ),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
