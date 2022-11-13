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
        elevation: 1,
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
            icon: IconButton(
              icon: const Icon(Icons.search),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                showSearch(context: context, delegate: CustomSearch());
              },
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
      body: Container(
        color: Colors.grey[100],
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
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  // data lay tu api
  List<String> allData = ['American', 'Russia', 'VietNam', 'China', 'Italy'];
  List<String> res = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.done,
            color: res.isEmpty ? Colors.grey : Colors.blue,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('text'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return RadioListTile<String>(
          groupValue: null,
          value: allData[index],
          onChanged: (value) {
            if (res.contains(value)) {
              res.remove(value);
            } else {
              res.add(value!);
            }
            print(res);
          },
          toggleable: true,
          title: Text(allData[index]),
        );
      }),
      itemCount: allData.length,
    );
  }
}
