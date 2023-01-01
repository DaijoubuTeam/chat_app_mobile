import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/widgets/friend_infor_detail.dart';

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

          return Column(
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              CircleAvatarCustom(
                urlImage: chatRoomInfor!.chatRoomAvatar!,
                widthImage: 120.w,
                heightImage: 120.h,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                chatRoomInfor.chatRoomName ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              if (state.chatRoomInformation!.type == "personal")
                const FriendInforDetail(),
            ],
          );
        } else {
          return const Text("Somethings wrrong!");
        }
      },
    );
  }
}
