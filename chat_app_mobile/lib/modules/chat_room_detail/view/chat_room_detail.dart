import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/widgets/friend_detail.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/widgets/group_detail.dart';
import 'package:chat_app_mobile/modules/home/view/view.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:go_router/go_router.dart';

import '../widgets/chat_room_information.dart';

class ChatRoomDetailPage extends StatelessWidget {
  const ChatRoomDetailPage({
    super.key,
    required this.chatRoomId,
  });

  static const namePage = 'chat-room-details';

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatRoomDetailBloc(
          chatRoomId: chatRoomId,
          authRepository: context.read<AuthRepository>(),
          chatRoomRepository: context.read<ChatRoomRepository>(),
          friendRepository: context.read<FriendRepository>()),
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
    return BlocListener<ChatRoomDetailBloc, ChatRoomDetailState>(
      listener: (_, state) {
        if (state is ChatRoomDetailGetDataSuccess &&
            state.status == FormzStatus.submissionSuccess) {
          context.goNamed(HomePage.namePage);
        }
      },
      child: Scaffold(
        appBar: const AppBarCustom(
          title: 'Chat Details',
        ),
        body: BlocBuilder<ChatRoomDetailBloc, ChatRoomDetailState>(
          builder: (context, state) {
            if (state is ChatRoomDetailGetDataSuccess) {
              return Container(
                height: double.infinity,
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const ChatRoomInformation(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        if (state.chatRoomInformation!.type == "group")
                          const GroupDetail(),
                        if (state.chatRoomInformation!.type == "personal")
                          const FriendDetail(),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ChatRoomDetailGetDataInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Something wrong!"),
              );
            }
          },
        ),
      ),
    );
  }
}
