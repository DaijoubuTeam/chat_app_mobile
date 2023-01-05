import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/friend_profile_bloc.dart';
import 'add_friend_button.dart';

class FriendInfor extends StatelessWidget {
  const FriendInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendProfileBloc, FriendProfileState>(
      builder: (context, state) {
        if (state is FriendProfileGetInforSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.verified,
                      color: state.friendInfor.isEmailVerified == true
                          ? Colors.green
                          : Colors.yellow,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: Text(
                  state.friendInfor.isEmailVerified == true
                      ? 'Email verified'
                      : 'Email not verified',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: state.friendInfor.isEmailVerified == true
                        ? Colors.green
                        : Colors.yellow,
                  ),
                ),
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.mail_outline,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: state.friendInfor.email == null ||
                        state.friendInfor.email == ""
                    ? Text(
                        'No email',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    : Text(
                        state.friendInfor.email ?? '',
                        style: TextStyle(fontSize: 16.sp),
                      ),
              ),
              const SizedBox(
                height: 4,
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.phone_outlined,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: state.friendInfor.phone == null ||
                        state.friendInfor.phone == ""
                    ? Text(
                        'No phone',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    : Text(
                        state.friendInfor.phone ?? '',
                        style: TextStyle(fontSize: 16.sp),
                      ),
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.info_outline_rounded,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: state.friendInfor.about == null ||
                        state.friendInfor.about == ""
                    ? Text(
                        'No bio',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    : Text(
                        state.friendInfor.about ?? '',
                        style: TextStyle(fontSize: 16.sp),
                      ),
              ),
              const SizedBox(
                height: 8,
              ),
              if (state.friendInfor.isSelf == false ||
                  state.friendInfor.isFriend == true)
                AddFriendButton(
                  isSentRequest: state.isSentRequest,
                ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
