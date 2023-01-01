import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/user.dart';

class UserApi {
  UserApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/user';

  final Dio _dio;

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

  Future<User> getUserById(String bearerToken, String userId) async {
    try {
      final url = '$basePath/$userId';
      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
      final userJson = response.data as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return user;
    } catch (e) {
      throw const HttpException(
          "Something wrong! Can't not get profile. Try again");
    }
  }

  Future<bool> requestVerifyEmail(String bearerToken) async {
    try {
      log(bearerToken);
      final url = '$basePath/verify-email';
      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
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
    } on DioError catch (_) {
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
      throw const HttpException("Sent email failed");
    }
  }

  Future<User> searchUserByEmailOrPhone(
      String inputSearch, String bearerToken) async {
    try {
      final url = '$basePath/search?search=$inputSearch';

      final response = await _dio.get(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}));

      final userJson = response.data as Map<String, dynamic>;

      final user = User.fromJson(userJson);

      return user;
    } on DioError catch (e) {
      log(e.response.toString(), name: 'search user by email or phone error');
      throw const HttpException("Search user by email or phone dio failed");
    } catch (e) {
      throw const HttpException("Search user by email or phone failed");
    }
  }
}
