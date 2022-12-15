import 'dart:developer';

import 'package:chat_app_api/chat_app_api.dart';
import 'package:dio/dio.dart';

class MessageApi {
  MessageApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/message/chat-room';

  Dio _dio;

  Future<List<Message>> getMessages(
      String bearerToken, String chatRoomId, int from, int to) async {
    final url = '$_serverUrl/message/$chatRoomId?before=$from&after=$to';

    final response = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );

    final messagesJson = response.data as List<dynamic>;

    final listMessages = messagesJson
        .map((messageJson) => Message.fromJson(messageJson))
        .toList();

    return listMessages;
  }

  Future<bool> sendMessage(
    String bearerToken,
    String chatRoomId,
    String content,
    String type,
  ) async {
    try {
      final url = '$basePath/$chatRoomId';
      final response = await _dio.post(url,
          options: Options(
            headers: {"authorization": 'Bearer $bearerToken'},
          ),
          data: {
            "message": content,
            "type": type,
          });
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'send message');
      return false;
    }
  }
}
