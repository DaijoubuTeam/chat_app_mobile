import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:chat_app_mobile/modules/notifications/widgets/notification_item_request_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_item_group_request.dart';

class ListNotification extends StatelessWidget {
  const ListNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state.runtimeType == NotificationGetListSuccess) {
          final listNotification =
              (state as NotificationGetListSuccess).listNotification;
          if (listNotification.isEmpty) {
            return const Center(
              child: Text('No notification now!'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationBloc>().add(NotificationInited());
            },
            child: Scrollbar(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    if (listNotification[index].notifyType ==
                        'friend-request') {
                      return NotificationItemRequestFriends(
                        fullname: listNotification[index]
                            .notificationSender
                            ?.fullname,
                        avatar:
                            listNotification[index].notificationSender?.avatar,
                        idSender:
                            listNotification[index].notificationSender?.uid,
                      );
                    }
                    if (listNotification[index].notifyType ==
                            'chat-room-invitation' &&
                        listNotification[index].chatRoomName != null) {
                      return NotificationItemGroupRequest(
                        fullname: listNotification[index]
                            .notificationSender
                            ?.fullname,
                        avatar:
                            listNotification[index].notificationSender?.avatar,
                        subtitle: listNotification[index].chatRoomName,
                        idSender:
                            listNotification[index].notificationSender?.uid,
                      );
                    }
                    return Container();
                  }),
                  itemCount: listNotification.length,
                ),
              ),
            ),
          );
        } else if (state.runtimeType == NotificationGetListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Somethings wrrong!'),
          );
        }
      },
    );
  }
}
