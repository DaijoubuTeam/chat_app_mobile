import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/chat_room.dart';

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

  Future<bool> addMemberChatRoom(
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

  Future<bool> deleteMemberChatRoom(
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
}
