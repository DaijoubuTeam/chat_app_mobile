import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import 'package:friend_repository/src/models/models.dart' as friend_model_repo;

class FriendRepository {
  FriendRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    return await _chatAppApi.sendFriendRequest(bearerToken, id);
  }

  Future<List<friend_model_repo.Friend>> getListRequestFriend(
      String bearerToken) async {
    final List<chat_app_api.Friend> friendsApi =
        await _chatAppApi.getListRequestFriend(bearerToken);
    final friendRepo =
        friendsApi.map((friendApi) => friendApi.toRepositoryFriend()).toList();
    return friendRepo;
  }
}

extension on chat_app_api.Friend {
  friend_model_repo.Friend toRepositoryFriend() {
    if (this == chat_app_api.Friend.empty) {
      return friend_model_repo.Friend.empty;
    }
    final friend = friend_model_repo.Friend(
        uid: uid,
        gender: gender,
        fullname: fullname,
        avatar: avatar,
        phone: phone,
        about: about,
        email: email);
    return friend;
  }
}
