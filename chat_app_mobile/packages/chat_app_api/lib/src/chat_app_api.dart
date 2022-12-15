import 'package:chat_app_api/src/api/webrtc_api.dart';
import 'package:chat_app_api/src/models/models.dart';
import 'package:dio/dio.dart';

import 'api/auth_api.dart';
import 'api/search_api.dart';
import 'api/message_api.dart';
import 'api/chat_room_api.dart';
import 'api/friend_api.dart';
import 'api/notification_api.dart';
import 'api/user_api.dart';

class ChatAppApi {
  ChatAppApi(
      {AuthApi? authApi,
      UserApi? userApi,
      FriendApi? friendApi,
      ChatRoomApi? chatRoomApi,
      MessageApi? chatMessageApi,
      NotificationApi? notificationApi,
      SearchApi? searchApi,
      WebRTCApi? webRTCApi,
      Dio? dio,
      required String serverUrl})
      : _authApi = authApi ?? AuthApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _userApi = userApi ?? UserApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _friendApi =
            friendApi ?? FriendApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _chatRoomApi =
            chatRoomApi ?? ChatRoomApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _messageApi = chatMessageApi ??
            MessageApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _notificationApi = notificationApi ??
            NotificationApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _searchApi = SearchApi(serverUrl: serverUrl, dio: dio ?? Dio()),
        _webRTCApi = WebRTCApi(serverUrl: serverUrl, dio: dio ?? Dio());

  AuthApi _authApi;
  UserApi _userApi;
  FriendApi _friendApi;
  ChatRoomApi _chatRoomApi;
  MessageApi _messageApi;
  NotificationApi _notificationApi;
  SearchApi _searchApi;
  WebRTCApi _webRTCApi;

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
      print(bearerToken);
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
  Future<List<User>> getListUserFriends(String bearerToken) async {
    return await _friendApi.getListUserFriends(bearerToken);
  }

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    return await _friendApi.sendFriendRequest(bearerToken, id);
  }

  Future<List<User>> getListRequestFriend(String bearerToken) async {
    return await _friendApi.getListRequestFriend(bearerToken);
  }

  Future<bool> actionWithFriend(
      String bearerToken, String id, String action) async {
    return await _friendApi.actionWithFriend(bearerToken, id, action);
  }

  Future<bool> deleteFriend(String bearerToken, String id) async {
    return await _friendApi.deleteFriend(bearerToken, id);
  }

  Future<List<User>> getListRequestsSentFriends(String bearerToken) async {
    return await _friendApi.getListRequestsSentFriends(bearerToken);
  }

  Future<bool> unsentFriendsRequest(String bearerToken, String id) async {
    return await _friendApi.unsentFriendsRequest(bearerToken, id);
  }

  //chat room api
  Future<List<ChatRoom>> getChatRoom(String bearerToken) async {
    return await _chatRoomApi.getChatRoom(bearerToken);
  }

  Future<ChatRoom> getChatRoomById(String bearerToken, String id) async {
    return await _chatRoomApi.getChatRoomById(bearerToken, id);
  }

  Future<bool> createNewChatRoom(
    String bearerToken,
    String chatRoomName,
    String? chatRoomAvatar,
    List<String>? memberIds,
  ) async {
    return await _chatRoomApi.createNewChatRoom(
      bearerToken,
      chatRoomName,
      chatRoomAvatar,
      memberIds,
    );
  }

  Future<bool> acceptJoinChat(String bearerToken, String chatRoomId) async {
    return await _chatRoomApi.acceptJoinChat(bearerToken, chatRoomId);
  }

  Future<bool> rejectJoinChat(String bearerToken, String chatRoomId) async {
    return await _chatRoomApi.rejectJoinChat(bearerToken, chatRoomId);
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

  Future<bool> inviteMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatRoomApi.inviteMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }

  Future<bool> removeMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatRoomApi.removeMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }

  Future<List<ChatRoom>> getAllChatRoomRequest(String bearerToken) async {
    return await _chatRoomApi.getAllChatRoomRequest(bearerToken);
  }

  //Chat app api
  Future<List<Message>> getMessages(
    String bearerToken,
    String chatRoomId,
    int from,
    int to,
  ) async {
    return await _messageApi.getMessages(bearerToken, chatRoomId, from, to);
  }

  Future<bool> sendMessage(String bearerToken, String chatRoomId,
      String content, String type) async {
    return await _messageApi.sendMessage(
        bearerToken, chatRoomId, content, type);
  }

  // notification api
  Future<List<Notification>> getUserNotification(String bearerToken) async {
    return await _notificationApi.getUserNotification(bearerToken);
  }

  Future<bool> readNotification(
      String bearerToken, String notificationId) async {
    return await _notificationApi.readNotification(bearerToken, notificationId);
  }

  Future<bool> deleteNotification(
      String bearerToken, String notificationId) async {
    return await _notificationApi.deleteNotification(
        bearerToken, notificationId);
  }

  //Search API
  Future<Search> getSearch(String bearerToken, String input) async {
    final res = await _searchApi.getSearch(bearerToken, input);
    return res;
  }

  //WebRTC Api
  Future<bool> postWebRTC(
      String bearerToken, String friendId, dynamic data) async {
    return await _webRTCApi.postWebRTC(bearerToken, friendId, data);
  }
}
