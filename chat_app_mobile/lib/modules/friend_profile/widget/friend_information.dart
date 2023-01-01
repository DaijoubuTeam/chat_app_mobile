import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'friend_infor.dart';

class FriendInformation extends StatelessWidget {
  const FriendInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendProfileBloc, FriendProfileState>(
      builder: (context, state) {
        if (state is FriendProfileGetInforSuccess) {
          return Column(
            children: <Widget>[
              CircleAvatarCustom(
                urlImage: state.friendInfor.avatar,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                state.friendInfor.fullname ?? '',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const FriendInfor(),
              const SizedBox(
                height: 32,
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
