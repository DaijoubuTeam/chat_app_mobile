import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/config/router/app_router.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:message_repository/message_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required FriendRepository friendRepository,
    required ChatRoomRepository chatRoomRepository,
    required MessageRepository messageRepository,
    required NotificationRepository notificationRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _friendRepository = friendRepository,
        _chatRoomRepository = chatRoomRepository,
        _messageRepository = messageRepository,
        _notificationRepository = notificationRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FriendRepository _friendRepository;
  final ChatRoomRepository _chatRoomRepository;
  final MessageRepository _messageRepository;
  final NotificationRepository _notificationRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _friendRepository),
        RepositoryProvider.value(value: _chatRoomRepository),
        RepositoryProvider.value(value: _messageRepository),
        RepositoryProvider.value(value: _notificationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(authRepository: _authRepository),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.grey[100],
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter(appBloc: context.read<AppBloc>()).router,
    );
  }
}
