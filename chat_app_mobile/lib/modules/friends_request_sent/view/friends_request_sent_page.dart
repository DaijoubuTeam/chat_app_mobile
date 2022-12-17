import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/friends_request_sent/bloc/friend_request_sent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';

import '../widgets/list_user_request_sent.dart';

class FriendsRequestSentPage extends StatelessWidget {
  const FriendsRequestSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FriendRequestSentBloc(
        context.read<AuthRepository>(),
        context.read<FriendRepository>(),
      ),
      child: const FriendsRequestSentView(),
    );
  }
}

class FriendsRequestSentView extends StatelessWidget {
  const FriendsRequestSentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<FriendRequestSentBloc>().add(FriendRequestSentInited());
        },
        child: const ListUserRequestSent(),
      ),
    );
  }
}
