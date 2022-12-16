import 'package:chat_app_mobile/modules/group_request_sent/bloc/group_request_sent_bloc.dart';
import 'package:chat_app_mobile/modules/group_request_sent/widgets/group_request_sent_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListGroupRequestSent extends StatelessWidget {
  const ListGroupRequestSent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupRequestSentBloc, GroupRequestSentState>(
      builder: (context, state) {
        final listRequest =
            (state as GroupRequestGetListSentSuccess).listGroupRequestSent;
        if (listRequest.isEmpty) {
          return const Center(
            child: Text("No request sent"),
          );
        }
        return Center(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              final requestInfor = listRequest[index];
              return GroupRequestSentItem(
                chatRoomId: requestInfor.chatRoom!.chatRoomId,
                friendId: requestInfor.to!.uid,
                friendAvatar: requestInfor.to!.avatar,
                friendName: requestInfor.to!.fullname,
                chatRoomName: requestInfor.chatRoom!.chatRoomName,
              );
            }),
            itemCount: listRequest.length,
          ),
        );
      },
    );
  }
}
