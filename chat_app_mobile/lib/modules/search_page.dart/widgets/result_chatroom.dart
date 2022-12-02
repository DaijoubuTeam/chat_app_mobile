import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/search_page.dart/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultChatRoom extends StatelessWidget {
  const ResultChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prev, current) => prev.chatrooms != current.chatrooms,
      builder: (context, state) {
        if (state.chatrooms != null && state.chatrooms!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              const Text(
                "Your groups",
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
                itemBuilder: (context, index) => PersonListItem(
                  avatar: state.chatrooms![index].chatRoomAvatar,
                  title: state.chatrooms![index].chatRoomName,
                  handleOnTab: () {},
                ),
                itemCount: state.chatrooms!.length,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
