import 'dart:io';

import 'package:dio/dio.dart';

import '../models/user.dart';

class AuthApi {
  AuthApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/auth';

  final Dio _dio;

  Future<User> verify(String bearerToken) async {
    try {
      final url = '$basePath/verify';
      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
      final userJson = response.data["user"] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return user;
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw const HttpException("Can't not verify user");
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final url = '$basePath/forgot-password';
      final res = await _dio.post(url, data: {'email': email});
      if (res.statusCode == 202) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
