import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          final chatRoomInfor =
              (state as ChatRoomDetailGetDataSuccess).chatRoomInformation;
          final friendInChatRoom = (state as ChatRoomDetailGetDataSuccess)
              .chatRoomInformation
              ?.friendsInChatRoom
              .toList();
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 48,
              ),
              (chatRoomInfor?.chatRoomAvatar != null)
                  ? CircleAvatarCustom(urlImage: chatRoomInfor!.chatRoomAvatar!)
                  : const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/empty_avatar.png'),
                      maxRadius: 48,
                    ),
              const SizedBox(
                height: 24,
              ),
              Text(
                chatRoomInfor?.chatRoomName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (state.chatRoomInformation!.type == "personal")
                Text(
                  (friendInChatRoom?[0].email != null)
                      ? "${friendInChatRoom![0].email}"
                      : "",
                  style: TextStyle(
                    //fontWeight: FontWeight.thi,
                    fontSize: 14.sp,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              if (state.chatRoomInformation!.type == "personal")
                Text(
                  (friendInChatRoom?[0].email != null)
                      ? "${friendInChatRoom![0].phone}"
                      : "",
                  style: TextStyle(
                    //fontWeight: FontWeight.thi,
                    fontSize: 14.sp,
                  ),
                ),
            ],
          );
        } else {
          return const Text("Somethings wrrong!");
        }
      },
    );
  }
}
