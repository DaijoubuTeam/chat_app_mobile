import 'dart:developer';

import 'package:chat_app_api/chat_app_api.dart';
import 'package:dio/dio.dart';

class ChatRoomApi {
  ChatRoomApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/chat-room';

  Dio _dio;

  Future<List<ChatRoom>> getChatRoom(String bearerToken) async {
    final url = basePath;

    final response = await _dio.get(url,
        options: Options(headers: {"authorization": 'Bearer $bearerToken'}));

    final chatRoomsJson = response.data["chatRooms"] as List<dynamic>;

    final chatRooms = chatRoomsJson
        .map((chatRoomJson) => ChatRoom.fromJson(chatRoomJson))
        .toList();

    return chatRooms;
  }

  Future<bool> createNewChatRoom(
      String bearerToken, String chatRoomName) async {
    try {
      final url = basePath;

      final response = await _dio.post(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}),
          data: {"chatRoomName": chatRoomName});

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'create new chat room');
      return false;
    }
  }

  Future<bool> acceptJoinChat(String bearerToken, String chatRoomId) async {
    try {
      final url = '$basePath/$chatRoomId/accept';

      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'create new chat room');
      return false;
    }
  }

  Future<bool> rejectJoinChat(String bearerToken, String chatRoomId) async {
    try {
      final url = '$basePath/$chatRoomId/reject';

      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'create new chat room');
      return false;
    }
  }

  Future<bool> updateChatRoom(
    String bearerToken,
    String chatRoomId,
    String chatRoomName,
    String chatRoomAvatar,
  ) async {
    try {
      final url = '$basePath/$chatRoomId';
      final response = await _dio.put(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}),
          data: {
            "chatRoomName": chatRoomName,
            "chatRoomAvatar": chatRoomAvatar,
          });
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'update chat room');
      return false;
    }
  }

  Future<bool> deleteGroupChatRoom(
      String bearerToken, String chatRoomId) async {
    try {
      final url = '$basePath/$chatRoomId';
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {"authorization": 'Bearer $bearerToken'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'delete group chat room');
      return false;
    }
  }

  Future<bool> inviteMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    try {
      final url = '$basePath/$chatRoomId/$memberId';
      final response = await _dio.post(
        url,
        options: Options(
          headers: {"authorization": 'Bearer $bearerToken'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'add member to chat room');
      return false;
    }
  }

  Future<bool> removeMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    try {
      final url = '$basePath/$chatRoomId/$memberId';
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {"authorization": 'Bearer $bearerToken'},
        ),
      );
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'add member to chat room');
      return false;
    }
  }

  Future<List<ChatRoom>> getAllChatRoomRequest(String bearerToken) async {
    final url = '$basePath/chat-room-requests';

    final response = await _dio.get(url,
        options: Options(headers: {"authorization": 'Bearer $bearerToken'}));

    final chatRoomsJson = response.data["chatRooms"] as List<dynamic>;

    final chatRooms = chatRoomsJson
        .map((chatRoomJson) => ChatRoom.fromJson(chatRoomJson))
        .toList();

    return chatRooms;
  }
}
