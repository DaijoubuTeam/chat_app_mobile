import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomInformation extends StatelessWidget {
  const ChatRoomInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomDetailBloc, ChatRoomDetailState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.runtimeType == ChatRoomDetailGetDataSuccess) {
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 48,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/empty_avatar.png'),
                maxRadius: 48,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                (state as ChatRoomDetailGetDataSuccess)
                        .chatRoomInformation!
                        .chatRoomName ??
                    '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // const Text(
              //   "Nguyễn Văn A",
              //   style: TextStyle(
              //     fontSize: 16,
              //   ),
              // ),
            ],
          );
        } else {
          return const Text("Somethings wrrong!");
        }
      },
    );
  }
}
