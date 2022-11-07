import 'package:chat_app_mobile/modules/friends_request/bloc/friends_request_bloc.dart';
import 'package:chat_app_mobile/modules/friends_request/widgets/item_user_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserRequest extends StatelessWidget {
  const ListUserRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsRequestBloc, FriendsRequestState>(
      buildWhen: (previous, current) => previous != current,
      builder: ((context, state) {
        if (state.runtimeType == FriendsRequestGetListSuccess) {
          final listFriendRequest =
              (state as FriendsRequestGetListSuccess).listFriendRequest;
          if (listFriendRequest.isEmpty) {
            return const Center(
              child: Text('No friends request now'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: ((context, index) {
                final itemUser = listFriendRequest[index];
                return ItemUserRequest(
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
          );
        } else if (state.runtimeType == FriendsRequestGetListInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: Text('Something wrongs!'));
      }),
    );
  }
}
