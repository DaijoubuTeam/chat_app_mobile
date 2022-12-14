import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/config/router/app_router.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/search/bloc/search_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:device_repository/device_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:message_repository/message_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:search_repository/search_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required FriendRepository friendRepository,
    required ChatRoomRepository chatRoomRepository,
    required MessageRepository messageRepository,
    required NotificationRepository notificationRepository,
    required SearchRepository searchRepository,
    required WebRTCRepostiory webRTCRepostiory,
    required DeviceRepository deviceRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _friendRepository = friendRepository,
        _chatRoomRepository = chatRoomRepository,
        _messageRepository = messageRepository,
        _notificationRepository = notificationRepository,
        _searchRepository = searchRepository,
        _webRTCRepostiory = webRTCRepostiory,
        _deviceRepository = deviceRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FriendRepository _friendRepository;
  final ChatRoomRepository _chatRoomRepository;
  final MessageRepository _messageRepository;
  final NotificationRepository _notificationRepository;
  final SearchRepository _searchRepository;
  final WebRTCRepostiory _webRTCRepostiory;
  final DeviceRepository _deviceRepository;

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
        RepositoryProvider.value(value: _searchRepository),
        RepositoryProvider.value(value: _webRTCRepostiory),
        RepositoryProvider.value(value: _deviceRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authRepository: _authRepository,
              webRTCRepostiory: _webRTCRepostiory,
              deviceRepository: _deviceRepository,
              notificationRepository: _notificationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => SearchBloc(_searchRepository, _authRepository),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  late GoRouter routerConfig;

  @override
  void didChangeDependencies() {
    routerConfig = AppRouter(appBloc: context.read<AppBloc>()).router;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'CS Chat App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.grey[100],
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
        );
      },
    );
  }
}
