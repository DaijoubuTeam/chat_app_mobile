import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/chat/bloc/chat_bloc.dart';
import 'package:chat_app_mobile/modules/chat/components/chat_item.dart';
import 'package:chat_app_mobile/modules/chat/components/chat_place_holder.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Expanded(
              child: Text(
                'CS Chat App',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) => previous != current,
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
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return ChatItem(
                      chatRoomId: listChatRoom[index].chatRoomId,
                      chatRoomName: listChatRoom[index].chatRoomName,
                      chatRoomAvatar: listChatRoom[index].chatRoomAvatar,
                    );
                  }),
                  itemCount: listChatRoom.length,
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
