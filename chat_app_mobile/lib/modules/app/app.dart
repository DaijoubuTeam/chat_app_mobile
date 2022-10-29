import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/config/router/app_router.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required FriendRepository friendRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _friendRepository = friendRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FriendRepository _friendRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _friendRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
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
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter(appBloc: context.read<AppBloc>()).router,
    );
  }
}
