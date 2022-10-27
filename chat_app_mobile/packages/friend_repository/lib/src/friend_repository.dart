import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class FriendRepository {
  FriendRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<bool> sendFriendRequest(String bearerToken, String id) async {
    return await _chatAppApi.sendFriendRequest(bearerToken, id);
  }
}
