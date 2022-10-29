import 'package:chat_app_api/chat_app_api.dart';
import 'package:dio/dio.dart';

class FriendApi {
  FriendApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/friend';

  final Dio _dio;

  Future<List<Friend>> getListUserFriends(String bearerToken) async {
    final url = basePath;
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    final listFriendRequest = res.data as List<dynamic>;
    final List<Friend> resListFriendRequest = listFriendRequest
        .map((friendApi) => Friend.fromJson(friendApi))
        .toList();
    return resListFriendRequest;
  }

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

  Future<List<Friend>> getListRequestFriend(String bearerToken) async {
    final url = '$basePath/friend-requests';
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    final listFriendRequest = res.data as List<dynamic>;
    final List<Friend> resListFriendRequest = listFriendRequest
        .map((friendApi) => Friend.fromJson(friendApi))
        .toList();
    return resListFriendRequest;
  }

  Future<bool> actionWithFriend(
      String bearerToken, String id, String action) async {
    final url = '$basePath/$id?action=$action';
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    if (res.statusCode == 204) {
      return true;
    }
    return false;
  }

  //delete friend
  Future<bool> deleteFriend(String bearerToken, String id) async {
    final url = '$basePath/$id';
    final res = await _dio.delete(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    if (res.statusCode == 204) {
      return true;
    }
    return false;
  }
}
