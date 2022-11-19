import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_button.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

import '../../friend_profile/view/view.dart';

class FindFriendPage extends StatelessWidget {
  const FindFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindFriendBloc(
        context.read<user_repository.UserRepository>(),
        context.read<auth_repository.AuthRepository>(),
      ),
      child: const FindFriendView(),
    );
  }
}

class FindFriendView extends StatelessWidget {
  const FindFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindFriendBloc, FindFriendState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.runtimeType == FindFriendFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not found')),
          );
          Navigator.pop(context);
        } else if (state.runtimeType == FindFriendSuccess) {
          context.read<FindFriendBloc>().add(FindFriendInputInitialized());

          final user_repository.User friendInfor =
              (state as FindFriendSuccess).friendInfor;

          Navigator.pop(context);

          context.pushNamed(
            FriendProfilePage.namePage,
            extra: friendInfor,
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: 32,
            left: 32,
            right: 32,
            bottom: MediaQuery.of(context).viewInsets.bottom + 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            FindFriendInput(),
            SizedBox(
              height: 8,
            ),
            FindFriendButton()
          ],
        ),
      ),
    );
  }
}
