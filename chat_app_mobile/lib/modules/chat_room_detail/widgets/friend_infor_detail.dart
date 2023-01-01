import 'package:chat_app_mobile/modules/chat_room_detail/bloc/chat_room_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendInforDetail extends StatelessWidget {
  const FriendInforDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomDetailBloc, ChatRoomDetailState>(
      builder: (context, state) {
        final friendInChatRoom = (state as ChatRoomDetailGetDataSuccess)
            .chatRoomInformation
            ?.friendsInChatRoom
            .toList();
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: Text(
                  (friendInChatRoom?[0].email != null)
                      ? "${friendInChatRoom![0].email}"
                      : "",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              if (friendInChatRoom?[0].phone != "")
                const Divider(
                  thickness: 1,
                ),
              if (friendInChatRoom?[0].phone != "")
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  minLeadingWidth: 24,
                  title: Text(
                    "${friendInChatRoom![0].phone}",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              if (friendInChatRoom?[0].about != "")
                const Divider(
                  thickness: 1,
                ),
              if (friendInChatRoom?[0].about != "")
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  minLeadingWidth: 24,
                  title: Text(
                    "${friendInChatRoom![0].about}",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
