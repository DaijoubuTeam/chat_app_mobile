import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindFriendButton extends StatelessWidget {
  const FindFriendButton({super.key});

  void handleFindFriendButton(BuildContext ctx) {
    ctx.read<FindFriendBloc>().add(const FindFriendButtonSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Find Friend',
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
