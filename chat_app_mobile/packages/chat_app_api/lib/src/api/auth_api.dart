import 'dart:io';

import 'package:dio/dio.dart';

import '../models/user.dart';

class AuthApi {
  AuthApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/auth';

  Dio _dio;

  Future<User> verify(String bearerToken) async {
    try {
      final url = '$basePath/verify';
      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
      final userJson = response.data["user"] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return user;
    } catch (e) {
      print(e);
      throw const HttpException("Can't not verify user");
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final url = '$basePath/forgot-password';
      await _dio.post(url, data: {'email': email});
    } catch (e) {
      throw const HttpException("Send request failed");
    }
  }

  Future<void> resetPassword(String token, String password) async {
    try {
      final url = '$basePath/reset-password';
      await _dio.patch(url,
          data: {'password': password}, queryParameters: {'token': token});
    } catch (e) {
      throw const HttpException("Send request failed");
    }
  }
}
