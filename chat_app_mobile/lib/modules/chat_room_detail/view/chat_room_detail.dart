import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/chat_room_information.dart';

class ChatRoomDetailPage extends StatelessWidget {
  const ChatRoomDetailPage(
      {super.key,
      required this.chatRoomId,});

  static const namePage = 'chat-room-details';

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatRoomDetailBloc(
        chatRoomId: chatRoomId,
        authRepository: context.read<AuthRepository>(),
        chatRoomRepository: context.read<ChatRoomRepository>(),
      ),
      child: const ChatRoomView(),
    );
  }
}

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: const Text('Chat Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ChatRoomInformation(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 32),
                child: Divider(
                  thickness: 1,
                ),
              ),
              SwitchListTile(
                value: true,
                onChanged: ((value) => {}),
                title: const Text(
                  'Stop notification',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // ListTile(
              //   title: const Text(
              //     'Edit Profile',
              //     style: TextStyle(fontSize: 18),
              //   ),
              //   trailing: const Icon(Icons.chevron_right),
              //   onTap: (() {
              //     //context.pushNamed(EditProfilePage.namePage);
              //   }),
              // ),
              // const ListTile(
              //   title: Text(
              //     'About us',
              //     style: TextStyle(fontSize: 18),
              //   ),
              //   trailing: Icon(Icons.chevron_right),
              // ),
              ListTile(
                iconColor: Colors.red[400],
                textColor: Colors.red[400],
                title: const Text(
                  'Block',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
