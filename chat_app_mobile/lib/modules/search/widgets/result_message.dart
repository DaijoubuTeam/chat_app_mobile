import 'package:chat_app_mobile/modules/chat/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class ResultMessage extends StatelessWidget {
  const ResultMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prev, current) => prev.messages != current.messages,
      builder: (context, state) {
        if (state.messages != null && state.messages!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              const Text(
                "Messages",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ChatItem(
                  chatRoomId: "1",
                  chatRoomName: state.messages![index].from?.fullname,
                  chatRoomAvatar: state.messages![index].from?.avatar,
                  latestMessage: state.messages![index].content,
                  time: state.messages![index].createdAt,
                ),
                itemCount: state.messages!.length,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
