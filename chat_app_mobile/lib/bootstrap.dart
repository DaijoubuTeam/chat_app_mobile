import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/src/app/app.dart';
import 'package:chat_app_mobile/src/app/app_bloc_observer.dart';
import 'package:flutter/material.dart';

void bootstrap(AuthRepository authRepository) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(MyApp(
      authRepository: authRepository,
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
