import 'dart:ui';

import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:user_repository/user_repository.dart' as user_repository;

import '../widget/card_information.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key, required this.friendId});

  final String friendId;

  static const String namePage = 'friend-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Friend information",
        appBarColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (_) => FriendProfileBloc(
          userRepository: context.read<user_repository.UserRepository>(),
          friendId: friendId,
          authRepository: context.read<auth_repository.AuthRepository>(),
          friendRepository: context.read<friend_repository.FriendRepository>(),
        ),
        child: const FriendProfileView(),
      ),
    );
  }
}

class FriendProfileView extends StatelessWidget {
  const FriendProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendProfileBloc, FriendProfileState>(
      builder: (context, state) {
        if (state is FriendProfileGetInforSuccess) {
          return Container(
            //color: Theme.of(context).backgroundColor,
            decoration: BoxDecoration(
              image: state.friendInfor.avatar != null
                  ? DecorationImage(
                      image: NetworkImage(state.friendInfor.avatar!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
              child: const Center(
                child: SingleChildScrollView(
                  child: CardInformation(),
                ),
              ),
            ),
          );
        }

        if (state is FriendProfileGetInforInLoad ||
            state is FriendProfileInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const Center(
          child: Text("Error!"),
        );
      },
    );
  }
}
