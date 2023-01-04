import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:chat_app_mobile/modules/friends/widgets/button_add_new_friend.dart';
import 'package:chat_app_mobile/modules/friends/widgets/list_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';

import '../widgets/button_request_friend.dart';

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final friendRepository = context.read<FriendRepository>();

    return BlocProvider(
      create: (_) => FriendsBloc(authRepository, friendRepository),
      child: const FriendsView(),
    );
  }
}

class FriendsView extends StatelessWidget {
  const FriendsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<FriendsBloc>().add(const FriendsInited());
        },
        child: Column(
          children: [
            const ButtonRequestFriend(),
            const ButtonAddNewFriend(),
            Divider(
              height: 25,
              color: Theme.of(context).backgroundColor,
              thickness: 16,
            ),
            const Expanded(
              child: Scrollbar(
                child: ListFriend(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
