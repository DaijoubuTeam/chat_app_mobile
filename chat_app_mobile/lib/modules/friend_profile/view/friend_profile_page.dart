import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/common/widgets/stateless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:chat_app_mobile/modules/friend_profile/widget/friend_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:user_repository/user_repository.dart' as user_repository;

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key, required this.friendInfor});

  final user_repository.User friendInfor;

  static const String namePage = 'friend-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Friend information"),
      body: BlocProvider(
        create: (_) => FriendProfileBloc(
            friendSearchInfor: friendInfor,
            authRepository: context.read<auth_repository.AuthRepository>(),
            friendRepository:
                context.read<friend_repository.FriendRepository>()),
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
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(56.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FriendInformation(),
              SizedBox(
                width: 200,
                child: ElevatedButtonCustom(
                  onPressed: () {
                    context
                        .read<FriendProfileBloc>()
                        .add(FriendProfileButtonSubmitted());
                  },
                  text: 'Add friend',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
