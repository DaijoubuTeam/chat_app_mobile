import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../modules/app/bloc/app_bloc.dart';
import '../../../../modules/notifications/view/notifications_page.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return IconButton(
          icon: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
              ),
              if (state is NotificationGetListSuccess &&
                  state.listNotification.isNotEmpty)
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
                        style: TextStyle(fontSize: 4.sp, color: Colors.white),
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
                context.read<NotificationBloc>().add(NotificationInited());
              },
            );
          },
        );
      },
    );
  }
}
