import 'package:dio/dio.dart';

class WebRTCApi {
  WebRTCApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => _serverUrl;

  final Dio _dio;

  Future<bool> postWebRTC(
      String bearerToken, String friendId, dynamic data) async {
    try {
      final url = '$basePath/webrtc/$friendId';
      final response = await _dio.post(url,
          options: Options(
            headers: {"authorization": 'Bearer $bearerToken'},
          ),
          data: data);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
