import 'package:chat_app_api/src/api/chat_room_api.dart';
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
      ChatRoomApi? chatRoomApi,
      Dio? dio,
      required String serverUrl})
      : _authApi = authApi ?? AuthApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _userApi = userApi ?? UserApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _friendApi =
            friendApi ?? FriendApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _chatRoomApi =
            chatRoomApi ?? ChatRoomApi(serverUrl: serverUrl, dio: dio ?? Dio());

  AuthApi _authApi;
  UserApi _userApi;
  FriendApi _friendApi;
  ChatRoomApi _chatRoomApi;

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
  Future<List<Friend>> getListUserFriends(String bearerToken) async {
    return await _friendApi.getListUserFriends(bearerToken);
  }

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

  Future<bool> deleteFriend(String bearerToken, String id) async {
    return await _friendApi.deleteFriend(bearerToken, id);
  }

  //chat room api
  Future<List<ChatRoom>> getChatRoom(String bearerToken) async {
    return await _chatRoomApi.getChatRoom(bearerToken);
  }

  Future<bool> createNewChatRoom(
      String bearerToken, String chatRoomName) async {
    return await _chatRoomApi.createNewChatRoom(bearerToken, chatRoomName);
  }

  Future<bool> updateChatRoom(
    String bearerToken,
    String chatRoomId,
    String chatRoomName,
    String chatRoomAvatar,
  ) async {
    return await _chatRoomApi.updateChatRoom(
        bearerToken, chatRoomId, chatRoomName, chatRoomAvatar);
  }

  Future<bool> deleteGroupChatRoom(
      String bearerToken, String chatRoomId) async {
    return await _chatRoomApi.deleteGroupChatRoom(bearerToken, chatRoomId);
  }

  Future<bool> addMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return _chatRoomApi.addMemberChatRoom(bearerToken, chatRoomId, memberId);
  }

  Future<bool> deleteMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatRoomApi.deleteMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }
}
