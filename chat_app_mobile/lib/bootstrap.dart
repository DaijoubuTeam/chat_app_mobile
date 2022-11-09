import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/modules/app/app.dart';
import 'package:chat_app_mobile/modules/app/app_bloc_observer.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:user_repository/user_repository.dart';

void bootstrap(AuthRepository authRepository, UserRepository userRepository,
    FriendRepository friendRepository, ChatRoomRepository chatRoomRepository) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(MyApp(
        authRepository: authRepository,
        userRepository: userRepository,
        friendRepository: friendRepository,
        chatRoomRepository: chatRoomRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
