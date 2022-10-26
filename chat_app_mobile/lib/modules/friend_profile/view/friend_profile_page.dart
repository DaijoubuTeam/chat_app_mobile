import 'package:chat_app_mobile/common/widgets/staless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/common/widgets/staless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key, required this.friendInfor});

  final user_repository.User friendInfor;

  static const String namePage = 'friend-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendInfor.uid),
      ),
      body: BlocProvider(
        create: (_) => FriendProfileBloc(),
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
      child: BlocBuilder<FriendProfileBloc, FriendProfileState>(
        buildWhen: (previous, current) => previous.uid != current.uid,
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatarCustom(urlImage: state.avatar),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButtonCustom(
                    onPressed: () {},
                    text: 'Add friends',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
