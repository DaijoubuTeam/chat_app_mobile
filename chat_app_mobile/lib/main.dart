import 'dart:developer';
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
import 'package:friend_repository/friend_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:web_socket_repository/web_socket_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //init hive and register adapte
  // await Hive.initFlutter();
  // Hive.registerAdapter<user_adapter.User>(user_adapter.UserAdapter());

  //set up url

  String serverUrl = 'https://localhost/api/v1';
  if (Platform.isAndroid) {
    // serverUrl = "https://10.0.2.2/api/v1";
    serverUrl = "https://10.0.21.242/api/v1";
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

  // initial repository
  final authenticationRepository = AuthRepository(
    firebaseAuth,
    chatAppApi,
  );
  final userRepository = UserRepository(chatAppApi);
  final friendRepostitory = FriendRepository(chatAppApi);

  await authenticationRepository.user.first;

  // // set up web socket
  // final webSocket = WebSocketChannelRepository(url: 'ws://localhost');
  // log(webSocket.toString(), name: "TEST WEB SOCKET");

  bootstrap(
    authenticationRepository,
    userRepository,
    friendRepostitory,
  );
}
