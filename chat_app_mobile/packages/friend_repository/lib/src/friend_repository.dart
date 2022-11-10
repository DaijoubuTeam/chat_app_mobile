import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import './models/models.dart' as friend_repository;

class FriendRepository {
  FriendRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<friend_repository.User>> getListUserFriends(
      String bearerToken) async {
    final List<chat_app_api.User> friendsApi =
        await _chatAppApi.getListUserFriends(bearerToken);
    final friendRepo =
        friendsApi.map((friendApi) => friendApi.toRepositoryUser()).toList();
    return friendRepo;
  }

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    return await _chatAppApi.sendFriendRequest(bearerToken, id);
  }

  Future<List<friend_repository.User>> getListRequestFriend(
      String bearerToken) async {
    final List<chat_app_api.User> friendsApi =
        await _chatAppApi.getListRequestFriend(bearerToken);
    final friendRepo =
        friendsApi.map((friendApi) => friendApi.toRepositoryUser()).toList();
    return friendRepo;
  }

  Future<bool> actionWithFriend(
      String bearerToken, String id, String action) async {
    return await _chatAppApi.actionWithFriend(bearerToken, id, action);
  }

  Future<bool> deleteFriend(String bearerToken, String id) async {
    return await _chatAppApi.deleteFriend(bearerToken, id);
  }
}

extension on chat_app_api.User {
  friend_repository.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return friend_repository.User.empty;
    }
    final user = friend_repository.User(
      uid: uid,
      username: username,
      fullname: fullname,
      avatar: avatar,
      phone: phone,
      about: about,
      email: email,
      isEmailVerified: isEmailVerified,
      isProfileFilled: isProfileFilled,
    );
    return user;
  }
}
