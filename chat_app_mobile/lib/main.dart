import 'dart:io' show HttpClient, Platform, X509Certificate;

import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:chat_app_mobile/services/notifications/local_notification.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:search_repository/search_repository.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:message_repository/message_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //set up url
  String serverUrl = "https://alpha.chatapp.daijoubuteam.xyz/api/v1";
  // if (Platform.isAndroid) {
  //   // serverUrl = "https://10.0.2.2/api/v1";
  //   serverUrl = "https://alpha.chatapp.daijoubu`team.xyz/api/v1";
  //   // firebase_auth.FirebaseAuth.instance.useAuthEmulator("10.0.2.2", 9099);
  //   // FirebaseStorage.instance.useStorageEmulator("10.0.2.2", 9099);
  // } else {
  //   firebase_auth.FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
  //   FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
  // }

  // Create dio
  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  // local notification
  await NotificationService().initialize();

  final chatAppApi = ChatAppApi(serverUrl: serverUrl, dio: dio);
  final firebaseAuth = firebase_auth.FirebaseAuth.instance;

  // initial repository
  final authenticationRepository = AuthRepository(
    firebaseAuth,
    chatAppApi,
  );
  final userRepository = UserRepository(chatAppApi);
  final friendRepository = FriendRepository(chatAppApi);
  final chatRoomRepository = ChatRoomRepository(chatAppApi);
  final messageRepository = MessageRepository(chatAppApi);
  final notificationRepository = NotificationRepository(chatAppApi);
  final searchRepository = SearchRepository(chatAppApi);
  final webRTCRepository = WebRTCRepostiory(chatAppApi);

  await authenticationRepository.user.first;

  SocketAPI.socketApi.socketConnect();

  bootstrap(
    authenticationRepository,
    userRepository,
    friendRepository,
    chatRoomRepository,
    messageRepository,
    notificationRepository,
    searchRepository,
    webRTCRepository,
  );
}
