import 'package:chat_app_api/chat_app_api.dart';
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
    } catch (_) {
      return false;
    }
  }

  Future<List<Friend>> getUserListFriend(String bearerToken) async {
    final url = '$basePath/friend-requests';
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    final listFriendRequest = res.data as List<dynamic>;
    final List<Friend> resListFriendRequest = listFriendRequest
        .map((friendApi) => Friend.fromJson(friendApi))
        .toList();
    return resListFriendRequest;
  }
}
