import 'dart:developer';

import 'package:user_repository/src/models/user.dart' as user_model;
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class UserRepository {
  UserRepository(chat_app_api.ChatAppApi chatAppApi) : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<user_model.User> getSelfProfile(String bearerToken) async {
    final apiUser = await _chatAppApi.getSelfProfile(bearerToken);
    return apiUser.toRepositoryUser();
  }

  Future<user_model.User> updateSelfProfile(
    user_model.User user,
    String bearerToken,
  ) async {
    final apiUser =
        await _chatAppApi.updateSelfProfile(user.toApiUser(), bearerToken);
    return apiUser.toRepositoryUser();
  }

  Future<user_model.User> searchUserByEmailOrPhone({
    required String inputSearch,
    required String bearerToken,
  }) async {
    try {
      final apiUser = await _chatAppApi.searchUserByEmailOrPhone(
        inputSearch,
        bearerToken,
      );
      return apiUser.toRepositoryUser();
    } catch (err) {
      log(err.toString(), name: "error search user by email or phone");
      throw "error search user by email or phone";
    }
  }

  // // create box collection and save "user" to user-box
  // Future<void> saveUserDataToCache(chat_app_api.User apiUser) async {
  //   final userBox = await Hive.openBox<user_adapter.User>('user-search-hive');
  //   final boxUser = user_adapter.User(
  //     uid: apiUser.uid,
  //     username: apiUser.username,
  //     fullname: apiUser.fullname,
  //     avatar: apiUser.avatar,
  //     phone: apiUser.phone,
  //     about: apiUser.about,
  //     email: apiUser.email,
  //   );
  //   await userBox.put("user", boxUser);

  //   final loki = userBox.get("user");
  //   log('$loki', name: 'user box');
  // }
}

extension on chat_app_api.User {
  user_model.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return user_model.User.empty;
    }
    final user = user_model.User(
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

extension on user_model.User {
  chat_app_api.User toApiUser() {
    if (this == user_model.User.empty) {
      return chat_app_api.User.empty;
    }
    final user = chat_app_api.User(
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
