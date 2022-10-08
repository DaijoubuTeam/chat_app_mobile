import 'dart:io' show HttpClient, Platform, X509Certificate;
import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:chat_app_mobile/src/login/view/view.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/adapter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String serverUrl = 'localhost';
  if (Platform.isAndroid) {
    serverUrl = "https://10.0.2.2/api/v1";
  }

  // Create dio

  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  // Set up firebase emulator

  // await FirebaseAuth.instance.useAuthEmulator(serverUrl, 9099);
  final chatAppApi = ChatAppApi(serverUrl: serverUrl, dio: dio);
  final firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final authenticationRepository = AuthRepository(
    firebaseAuth,
    chatAppApi,
  );

  await authenticationRepository.user.first;
  bootstrap(authenticationRepository);
}
