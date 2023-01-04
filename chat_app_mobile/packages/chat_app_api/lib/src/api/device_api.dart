import 'package:chat_app_api/chat_app_api.dart';
import 'package:dio/dio.dart';

class DeviceApi {
  DeviceApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/device';

  final Dio _dio;

  Future<List<Device>> getDevices(String bearerToken) async {
    try {
      final url = basePath;
      final res = await _dio.get(
        url,
        options: Options(
          headers: {"authorization": 'Bearer $bearerToken'},
        ),
      );
      if (res.statusCode == 200) {
        final listDeviceApi = res.data as List<dynamic>;

        final List<Device> listDevice = listDeviceApi
            .map((deviceApi) => Device.fromJson(deviceApi))
            .toList();

        return listDevice;
      } else {
        throw Exception("Something wrong! Try again");
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> postDevice(
    String bearerToken,
    String deviceId,
    String name,
    String fcmToken,
  ) async {
    try {
      final url = basePath;

      final response = await _dio.post(url,
          options: Options(headers: {"authorization": 'Bearer $bearerToken'}),
          data: {
            "deviceId": deviceId,
            "name": name,
            "token": fcmToken,
          });

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteUserDevice(
    String bearerToken,
    String deviceId,
  ) async {
    try {
      final url = '$basePath/$deviceId';

      final response = await _dio.delete(
        url,
        options: Options(
          headers: {"authorization": 'Bearer $bearerToken'},
        ),
      );

      if (response.statusCode == 200) {
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
