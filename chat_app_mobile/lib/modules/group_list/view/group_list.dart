import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_list/bloc/group_list_bloc.dart';
import 'package:chat_app_mobile/modules/group_list/widgets/button_request_group.dart';
import 'package:chat_app_mobile/modules/notifications/bloc/notification_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:notification_repository/notification_repository.dart';

import '../widgets/button_create_group.dart';
import '../widgets/list_group_joined.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GroupListBloc(
            context.read<AuthRepository>(),
            context.read<ChatRoomRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => NotificationBloc(
            authRepository: context.read<AuthRepository>(),
            notificationRepository: context.read<NotificationRepository>(),
            friendRepository: context.read<FriendRepository>(),
            chatRoomRepository: context.read<ChatRoomRepository>(),
          ),
        ),
      ],
      child: const GroupListView(),
    );
  }
}

class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<GroupListBloc>().add(GroupListInited());
        },
        child: Column(
          children: <Widget>[
            const ButtonRequestGroup(),
            const ButtonCreateGroup(),
            Divider(
              height: 25,
              color: Theme.of(context).backgroundColor,
              thickness: 16,
            ),
            const Expanded(
              child: Scrollbar(
                child: ListGroupJoined(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
