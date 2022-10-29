import 'package:chat_app_api/src/api/friend_api.dart';
import 'package:chat_app_api/src/api/user_api.dart';
import 'package:chat_app_api/src/models/models.dart';
import 'package:dio/dio.dart';

import 'api/auth_api.dart';

class ChatAppApi {
  ChatAppApi(
      {AuthApi? authApi,
      UserApi? userApi,
      FriendApi? friendApi,
      Dio? dio,
      required String serverUrl})
      : _authApi = authApi ?? AuthApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _userApi = userApi ?? UserApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _friendApi =
            friendApi ?? FriendApi(serverUrl: serverUrl, dio: dio ?? Dio());

  AuthApi _authApi;
  UserApi _userApi;
  FriendApi _friendApi;

  //auth api

  Future<User> verifyUser(String bearerToken) async {
    try {
      final user = await _authApi.verify(bearerToken);
      return user;
    } catch (e) {
      return User.empty;
    }
  }

  Future<void> forgotPassword(String email) {
    return _authApi.forgotPassword(email);
  }

  Future<void> resetPassword(String token, String password) {
    return _authApi.resetPassword(token, password);
  }

  // user api

  Future<User> getSelfProfile(String bearerToken) async {
    try {
      final user = await _userApi.getSelfProfile(bearerToken);
      return user;
    } catch (e) {
      return User.empty;
    }
  }

  Future<User> updateSelfProfile(User user, String bearerToken) async {
    try {
      final resUser = await _userApi.updateProfile(user, bearerToken);
      return resUser;
    } catch (e) {
      return User.empty;
    }
  }

  Future<void> verifyEmail(String bearerToken) async {
    await _userApi.verifyEmail(bearerToken);
  }

  Future<User> searchUserByEmailOrPhone(
      String inputSearch, String bearerToken) async {
    try {
      final resUser =
          await _userApi.searchUserByEmailOrPhone(inputSearch, bearerToken);
      return resUser;
    } catch (e) {
      return User.empty;
    }
  }

  //friend api
  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    return await _friendApi.sendFriendRequest(bearerToken, id);
  }

  Future<List<Friend>> getListRequestFriend(String bearerToken) async {
    return await _friendApi.getListRequestFriend(bearerToken);
  }

  Future<bool> actionWithFriend(
      String bearerToken, String id, String action) async {
    return await _friendApi.actionWithFriend(bearerToken, id, action);
  }
}
