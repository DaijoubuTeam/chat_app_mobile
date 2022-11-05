import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final chatRoomInfor = state as ChatDetailInitial;
        return Row(
          children: <Widget>[
            //Avatar
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(chatRoomInfor.chatRoomAvatar ??
                      'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png'),
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
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chatRoomInfor.chatRoomName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Active 3m ago',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
