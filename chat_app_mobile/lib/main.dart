import 'dart:io' show HttpClient, X509Certificate;

import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:chat_app_mobile/services/notifications/local_notification.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:device_repository/device_repository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:friend_repository/friend_repository.dart';
import 'package:search_repository/search_repository.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:message_repository/message_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //set up url
  String serverUrl = "https://beta.chatapp.daijoubuteam.xyz/api/v1";

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
  final authenticationRepository = AuthRepository(firebaseAuth, chatAppApi);
  final userRepository = UserRepository(chatAppApi);
  final friendRepository = FriendRepository(chatAppApi);
  final chatRoomRepository = ChatRoomRepository(chatAppApi);
  final messageRepository = MessageRepository(chatAppApi);
  final notificationRepository = NotificationRepository(chatAppApi);
  final searchRepository = SearchRepository(chatAppApi);
  final webRTCRepository = WebRTCRepostiory(chatAppApi);
  final deviceRepository = DeviceRepository(chatAppApi);

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
    deviceRepository,
  );
}
