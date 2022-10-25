import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:chat_app_mobile/modules/friend_profile/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FindFriendButton extends StatelessWidget {
  const FindFriendButton({super.key});

  void handleFindFriendButton(BuildContext ctx) {
    ctx.read<FindFriendBloc>().add(const FindFriendButtonSubmitted());
    // ctx.pushNamed(FriendProfilePage.namePage);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => handleFindFriendButton(context),
        // border radius
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Find Friend',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
