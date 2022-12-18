import 'package:chat_app_mobile/modules/friends_request_sent/widgets/item_user_request_sent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../friends_request/bloc/friends_request_bloc.dart';
import '../bloc/friend_request_sent_bloc.dart';

class ListUserRequestSent extends StatelessWidget {
  const ListUserRequestSent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendRequestSentBloc, FriendRequestSentState>(
      buildWhen: (previous, current) => previous != current,
      builder: ((context, state) {
        if (state is FriendRequestSentGetListSuccess) {
          final listFriendRequest = state.listFriendRequestSent;
          if (listFriendRequest.isEmpty) {
            return const Center(
              child: Text('No friends request now'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Scrollbar(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  final itemUser = listFriendRequest[index];
                  return ItemUserRequestSent(
                    key: UniqueKey(),
                    uid: itemUser.uid,
                    gender: itemUser.gender,
                    fullname: itemUser.fullname,
                    avatar: itemUser.avatar,
                    phone: itemUser.phone,
                    about: itemUser.about,
                    email: itemUser.email,
                  );
                }),
                itemCount: listFriendRequest.length,
              ),
            ),
          );
        } else if (state.runtimeType == FriendsRequestGetListInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('Something wrongs!'));
      }),
    );
  }
}
