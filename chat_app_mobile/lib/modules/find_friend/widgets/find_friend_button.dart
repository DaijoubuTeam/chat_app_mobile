import 'package:chat_app_mobile/modules/friend_profile/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FindFriendButton extends StatelessWidget {
  const FindFriendButton({super.key});

  void handleFindFriendButton(BuildContext ctx) {
    ctx.pushNamed(FriendProfilePage.namePage);
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
