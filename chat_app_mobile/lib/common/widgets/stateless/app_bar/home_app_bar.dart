import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:chat_app_mobile/modules/notifications/view/view.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:notification_repository/notification_repository.dart';

import '../../../../modules/search/view/search_button.dart';

class HomeAppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarCustom({
    super.key,
    this.bottomWidget,
    this.numberNotification = 0,
  });

  final PreferredSizeWidget? bottomWidget;
  final int numberNotification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(
        authRepository: context.read<AuthRepository>(),
        notificationRepository: context.read<NotificationRepository>(),
        friendRepository: context.read<FriendRepository>(),
        chatRoomRepository: context.read<ChatRoomRepository>(),
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Expanded(
              child: Text(
                'CS Chat App',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearch());
            },
          ),
          //const SearchButton(),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return IconButton(
                icon: Stack(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Theme.of(context).primaryColor,
                    ),
                    if (state.runtimeType == NotificationGetListSuccess &&
                        (state as NotificationGetListSuccess)
                            .listNotification
                            .isNotEmpty)
                      Positioned(
                        right: -1,
                        bottom: -1,
                        child: Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              state.listNotification.length.toString(),
                              style: TextStyle(
                                  fontSize: 4.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (ctx) => const NotificationsPage()))
                      .then(
                    (_) {
                      context
                          .read<NotificationBloc>()
                          .add(NotificationInited());
                    },
                  );
                },
              );
            },
          )
        ],
        bottom: bottomWidget,
      ),
    );
  }

  @override
  Size get preferredSize {
    if (bottomWidget != null) {
      return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
    } else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}
