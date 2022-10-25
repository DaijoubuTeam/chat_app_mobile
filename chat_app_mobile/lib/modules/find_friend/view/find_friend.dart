import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_button.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class FindFriendPage extends StatelessWidget {
  const FindFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindFriendBloc(
        context.read<UserRepository>(),
        context.read<AuthRepository>(),
      ),
      child: const FindFriendView(),
    );
  }
}

class FindFriendView extends StatelessWidget {
  const FindFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
