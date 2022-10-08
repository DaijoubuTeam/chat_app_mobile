import 'package:chat_app_api/chat_app_api.dart';
import 'package:chat_app_mobile/bootstrap.dart';
import 'package:chat_app_mobile/firebase_options.dart';
import 'package:chat_app_mobile/src/signup/view/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final chatAppApi = ChatAppApi();
  final firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final authenticationRepository = AuthRepository(
    firebaseAuth,
    chatAppApi,
  );

  await authenticationRepository.user.first;
  bootstrap(authenticationRepository);
}
