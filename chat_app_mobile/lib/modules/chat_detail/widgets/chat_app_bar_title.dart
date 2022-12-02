import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      buildWhen: (previous, current) =>
          previous.chatRoomName != current.chatRoomName,
      builder: (context, state) {
        return Row(
          children: <Widget>[
            //Avatar
            Stack(
              children: [
                (state.chatRoomAvatar != null)
                    ? CircleAvatarCustom(
                        urlImage: state.chatRoomAvatar,
                        widthImage: 40,
                        heightImage: 40,
                      )
                    : const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/empty_avatar.png'),
                        maxRadius: 20,
                      ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    state.chatRoomName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // const Text(
                  //   'Active 3m ago',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //   ),
                  // )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
