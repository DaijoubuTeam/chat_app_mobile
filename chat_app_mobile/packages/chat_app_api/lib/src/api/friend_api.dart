import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class FriendApi {
  FriendApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/friend';

  final Dio _dio;

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    try {
      final url = basePath;
      final res = await _dio.post(url,
          options: Options(
              headers: {"authorization": 'Bearer $bearerToken'},
              validateStatus: (status) {
                return status! < 500;
              }),
          data: {"id": id});
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // log(e.toString(), name: "post send friend failed");
      // throw const HttpException("Sent friend request failed");
      return false;
    }
  }
}
