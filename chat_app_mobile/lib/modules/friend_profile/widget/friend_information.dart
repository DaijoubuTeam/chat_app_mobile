import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendInformation extends StatelessWidget {
  const FriendInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendProfileBloc, FriendProfileState>(
      buildWhen: (previous, current) =>
          previous != current && current.runtimeType == FriendProfileInitial,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            CircleAvatarCustom(
                urlImage: (state as FriendProfileInitial).friendInfor.avatar),
            const SizedBox(
              height: 32,
            ),
            Text(
              state.friendInfor.fullname ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              state.friendInfor.about ?? '',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        );
      },
    );
  }
}
