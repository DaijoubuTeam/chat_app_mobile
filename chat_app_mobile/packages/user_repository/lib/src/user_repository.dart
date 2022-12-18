import 'dart:developer';

import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import './models/models.dart' as user_model;

class UserRepository {
  UserRepository(chat_app_api.ChatAppApi chatAppApi) : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<user_model.User> getSelfProfile(String bearerToken) async {
    log(bearerToken);
    final apiUser = await _chatAppApi.getSelfProfile(bearerToken);
    return apiUser.toRepositoryUser();
  }

  Future<bool> requestVerifyEmail(String bearerToken) async {
    return await _chatAppApi.requestVerifyEmail(bearerToken);
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
