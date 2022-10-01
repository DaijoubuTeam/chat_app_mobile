import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import './models/models.dart';

class AuthRepository {
  AuthRepository(
      firebase_auth.FirebaseAuth auth, chat_app_api.ChatAppApi chatAppApi)
      : _auth = auth,
        _chatAppApi = chatAppApi,
        _currentUser = User.empty;

  final firebase_auth.FirebaseAuth _auth;
  final chat_app_api.ChatAppApi _chatAppApi;

  User _currentUser;

  Stream<User> get user {
    return _auth.authStateChanges().asyncMap(_updateCurrentUser);
  }

  Future<User> _updateCurrentUser(firebase_auth.User? user) async {
    if (user == null || user.isAnonymous) {
      return User.empty;
    }
    final bearerToken = await user.getIdToken();
    _currentUser = await _getSelfProfile(bearerToken);
    return _currentUser;
  }

  User get currentUser => _currentUser;

  Future<User> _getSelfProfile(String bearerToken) async {
    final apiUser = await _chatAppApi.getSelfProfile(bearerToken);
    return apiUser.toRepositoryUser();
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
