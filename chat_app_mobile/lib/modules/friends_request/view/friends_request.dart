import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/friends_request/bloc/friends_request_bloc.dart';
import 'package:chat_app_mobile/modules/friends_request/widgets/list_user_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';

class FriendsRequestPage extends StatelessWidget {
  //static String namePage = 'friends-request';
  const FriendsRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FriendsRequestBloc(
        context.read<AuthRepository>(),
        context.read<FriendRepository>(),
      ),
      child: const FriendsRequestView(),
    );
  }
}

class FriendsRequestView extends StatelessWidget {
  const FriendsRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<FriendsRequestBloc>()
              .add(const FriendRequestPageInited());
        },
        child: const ListUserRequest(),
      ),
    );
  }
}
