import 'package:chat_app_mobile/common/widgets/staless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.runtimeType == FriendsGetListSuccess) {
          final listFriend = (state as FriendsGetListSuccess).listFriend;
          if (listFriend.isEmpty) {
            return const Center(
              child: Text('No friends!'),
            );
          }
          return ListView.builder(
            itemBuilder: ((context, index) {
              return PersonListItem(
                handleOnTab: () => {},
                avatar: listFriend[index].avatar,
                title: listFriend[index].fullname,
                subTitle: listFriend[index].phone,
              );
            }),
            itemCount: listFriend.length,
          );
        }
        if (state.runtimeType == FriendsGetListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('Somethings wrongs'),
        );
      },
    );
  }
}
