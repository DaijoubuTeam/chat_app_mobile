import 'dart:developer';

import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import './models/models.dart';

class AuthRepository {
  AuthRepository(
      firebase_auth.FirebaseAuth auth, chat_app_api.ChatAppApi chatAppApi,
      {GoogleSignIn? googleSignIn})
      : _auth = auth,
        _chatAppApi = chatAppApi,
        _currentUser = User.empty,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _auth;
  final chat_app_api.ChatAppApi _chatAppApi;
  final GoogleSignIn _googleSignIn;

  Future<String>? get bearToken async {
    final idToken = await _auth.currentUser?.getIdToken();
    if (idToken == null) {
      return '';
    } else {
      return idToken;
    }
  }

  User _currentUser;

  Stream<User> get user {
    return _auth.authStateChanges().asyncMap(_updateCurrentUser);
  }

  Future<User> _updateCurrentUser(firebase_auth.User? user) async {
    if (user == null || user.isAnonymous) {
      _currentUser = User.empty;
      return User.empty;
    }
    final bearerToken = await user.getIdToken();
    _currentUser = await _getSelfProfile(bearerToken);
    return _currentUser;
  }

  User get currentUser => _currentUser;

  Future<User> _getSelfProfile(String bearerToken) async {
    // final apiUser = await _chatAppApi.getSelfProfile(bearerToken);
    final apiUser = await _chatAppApi.verifyUser(bearerToken);
    return apiUser.toRepositoryUser();
  }

  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(_auth.currentUser.toString(), name: 'login with email and password');
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (err) {
      log(err.toString(), name: 'Log out error');
    }
  }
}

extension on chat_app_api.User {
  User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return User.empty;
    }
    final user = User(
      uid: uid,
      username: username,
      fullname: fullname,
      avatar: avatar,
      phone: phone,
      about: about,
      email: email,
      isEmailVerified: isEmailVerified,
      isProfileFilled: isProfileFilled,
      friends: friends,
      friendRequests: friendRequests,
      bans: bans,
    );
    return user;
  }
}
