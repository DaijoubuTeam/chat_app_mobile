import 'package:chat_app_api/chat_app_api.dart';

class WebRTCRepostiory {
  WebRTCRepostiory(ChatAppApi chatAppApi) : _chatAppApi = chatAppApi;

  final ChatAppApi _chatAppApi;

  Future<bool> postWebRTC(
      String bearerToken, String friendId, dynamic data) async {
    return await _chatAppApi.postWebRTC(bearerToken, friendId, data);
  }
}
