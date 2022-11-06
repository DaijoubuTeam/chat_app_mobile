import 'dart:io' show HttpClient, Platform, X509Certificate;
import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:dio/adapter.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

  final chatAppApi = ChatAppApi(serverUrl: serverUrl, dio: dio);

  final firebaseAuth = firebase_auth.FirebaseAuth.instance;

  // initial repository
  final authenticationRepository = AuthRepository(
    firebaseAuth,
    chatAppApi,
  );
  final userRepository = UserRepository(chatAppApi);
  final friendRepostitory = FriendRepository(chatAppApi);
  final chatRoomRepository = ChatRoomRepository(chatAppApi);

  SocketAPI.SocketApi.socketConnect();

  await authenticationRepository.user.first;

  bootstrap(authenticationRepository, userRepository, friendRepostitory,
      chatRoomRepository);
}
