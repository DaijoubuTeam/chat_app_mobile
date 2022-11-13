import 'package:chat_app_api/chat_app_api.dart';
import 'package:dio/dio.dart';

class FriendApi {
  FriendApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/friend';

  final Dio _dio;

  Future<List<User>> getListUserFriends(String bearerToken) async {
    final url = basePath;
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    final listFriendRequest = res.data as List<dynamic>;
    final List<User> resListFriendRequest =
        listFriendRequest.map((friendApi) => User.fromJson(friendApi)).toList();
    return resListFriendRequest;
  }

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    try {
      final url = basePath;
      final res = await _dio.post(url,
          options: Options(
            headers: {"authorization": 'Bearer $bearerToken'},
          ),
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

  Future<List<User>> getListRequestFriend(String bearerToken) async {
    final url = '$basePath/friend-requests';
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    final listFriendRequestJson = res.data as List<dynamic>;
    final List<User> resListFriendRequest = listFriendRequestJson
        .map((friendApi) => User.fromJson(friendApi))
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

  Future<List<User>> getListRequestsSentFriends(String bearerToken) async {
    final url = '$basePath/friend-requests-sent';
    final res = await _dio.get(
      url,
      options: Options(
        headers: {"authorization": 'Bearer $bearerToken'},
      ),
    );
    final listFriendRequest = res.data as List<dynamic>;
    final List<User> resListFriendRequest =
        listFriendRequest.map((friendApi) => User.fromJson(friendApi)).toList();
    return resListFriendRequest;
  }

  Future<bool> unsentFriendsRequest(String bearerToken, String id) async {
    final url = '$basePath/friend-requests-sent/$id';
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
