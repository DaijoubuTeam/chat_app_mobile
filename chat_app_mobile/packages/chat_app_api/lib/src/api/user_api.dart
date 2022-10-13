import 'dart:io';

import 'package:dio/dio.dart';

import '../models/user.dart';

class UserApi {
  UserApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/user';

  Dio _dio;

  Future<User> getSelfProfile(String bearerToken) async {
    try {
      final url = '$basePath/self';
      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
      final userJson = response.data["user"] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return user;
    } catch (e) {
      throw const HttpException("Can't not get profile");
    }
  }

  Future<User> updateProfile(User user, String bearerToken) async {
    try {
      final url = '$basePath/self';
      final response = await _dio.put(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}),
          data: {
            "username": user.username ?? "",
            "fullname": user.fullname ?? "",
            "uid": user.uid,
            "avatar": user.avatar ?? "",
            "phone": user.phone ?? "",
            "about": user.about ?? "",
          });
      final userJson = response.data["user"] as Map<String, dynamic>;
      final resUser = User.fromJson(userJson);
      return resUser;
    } on DioError catch (e) {
      print(e.response);
      throw const HttpException("Update failed");
    } catch (e) {
      throw const HttpException("Update failed");
    }
  }

  Future<void> verifyEmail(String bearerToken) async {
    try {
      final url = '$basePath/verify-email';
      await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
    } catch (e) {
      throw HttpException("Sent email failed");
    }
  }
}
