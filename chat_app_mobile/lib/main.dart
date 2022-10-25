import 'dart:io' show HttpClient, Platform, X509Certificate;
import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:dio/adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hive_repository/src/models/user.dart' as user_adapter;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //init hive and register adapter

  await Hive.initFlutter();
  Hive.registerAdapter<user_adapter.User>(user_adapter.UserAdapter());

  //set up url

  String serverUrl = 'https://localhost/api/v1';
  if (Platform.isAndroid) {
    serverUrl = "https://192.168.1.5/api/v1";
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
  final userRepository = UserRepository(chatAppApi);

  await authenticationRepository.user.first;
  bootstrap(authenticationRepository, userRepository);
}
