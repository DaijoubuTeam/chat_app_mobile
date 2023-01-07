import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../friends_request_tab/view/friends_request_tab_page.dart';

class ButtonRequestFriend extends StatelessWidget {
  const ButtonRequestFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
            title: const Text('Friends Request'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state is FriendsGetListSuccess &&
                    state.numberRequestFriend > 0)
                  Container(
                    height: 14.h,
                    width: 14.w,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        state.numberRequestFriend.toString(),
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 8.w,
                ),
                if (state is FriendsGetListSuccess &&
                    state.numberSentRequestFriend > 0)
                  Container(
                    height: 14.h,
                    width: 14.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        state.numberSentRequestFriend.toString(),
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(Icons.chevron_right)
              ],
            ),
            onTap: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (_) => const FriendRequestTabPage()))
                  .then(
                (_) {
                  context.read<AppBloc>().add(AppNotificationNumberChanged());
                  context.read<FriendsBloc>().add(const FriendsInited());
                },
              );
            },
          ),
        );
      },
    );
  }
}
