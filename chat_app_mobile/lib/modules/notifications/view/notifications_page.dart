import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:chat_app_mobile/modules/notifications/widgets/list_notification.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:notification_repository/notification_repository.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const String namePage = 'notifications';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(
        authRepository: context.read<AuthRepository>(),
        notificationRepository: context.read<NotificationRepository>(),
        friendRepository: context.read<FriendRepository>(),
        chatRoomRepository: context.read<ChatRoomRepository>(),
      ),
      child: const NotificationsView(),
    );
  }
}

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(title: "Notifications"),
      body: ListNotification(),
    );
  }
}
