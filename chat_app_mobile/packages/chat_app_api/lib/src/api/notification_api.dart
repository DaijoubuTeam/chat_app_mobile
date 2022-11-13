import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/models.dart';

class NotificationApi {
  NotificationApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/notification';

  Dio _dio;

  Future<List<Notification>> getUserNotification(String bearerToken) async {
    final url = basePath;

    final response = await _dio.get(url,
        options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
    final notificationsJson = response.data as List<dynamic>;

    final listNotification = notificationsJson
        .map((notificationJson) => Notification.fromJson(notificationJson))
        .toList();

    return listNotification;
  }

  Future<bool> readNotification(
      String bearerToken, String notificationId) async {
    try {
      final url = '$basePath/$notificationId';
      final response = await _dio.put(url,
          options: Options(
            headers: {"authorization": 'Bearer $bearerToken'},
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'toggle notification');
      return false;
    }
  }

  Future<bool> deleteNotification(
      String bearerToken, String notificationId) async {
    try {
      final url = '$basePath/$notificationId';
      final response = await _dio.delete(url,
          options: Options(
            headers: {"authorization": 'Bearer $bearerToken'},
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'delete toggle notification');
      return false;
    }
  }
}
