import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_button.dart';
import 'package:chat_app_mobile/modules/find_friend/widgets/find_friend_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

import '../../friend_profile/view/view.dart';

class FindFriendPage extends StatelessWidget {
  const FindFriendPage({super.key});

  static const namePage = "find-friend";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindFriendBloc(
        context.read<user_repository.UserRepository>(),
        context.read<auth_repository.AuthRepository>(),
      ),
      child: const Scaffold(
        appBar: AppBarCustom(title: "Find Friend"),
        body: FindFriendView(),
      ),
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
          FlutterToastCustom.showToast("User not found!", "error");
          Navigator.pop(context, {"isFindFriend": false, "uid": null});
        } else if (state.runtimeType == FindFriendSuccess) {
          context.read<FindFriendBloc>().add(FindFriendInputInitialized());

          final user_repository.User friendInfor =
              (state as FindFriendSuccess).friendInfor;
          Navigator.pop(
              context, {"isFindFriend": true, "uid": friendInfor.uid});
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (ctx) => FriendProfilePage(
          //           friendId: friendInfor.uid,
          //         )));

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
          children: <Widget>[
            SizedBox(
              height: 8.h,
            ),
            const FindFriendInput(),
            SizedBox(
              height: 8.h,
            ),
            const FindFriendButton()
          ],
        ),
      ),
    );
  }
}
