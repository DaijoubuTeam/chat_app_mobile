import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import 'package:chat_message_repository/src/models/models.dart'
    as chat_message_repo;

class ChatMessageRepository {
  ChatMessageRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;
  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<chat_message_repo.ChatMessage>> getMessages(
    String bearerToken,
    String chatRoomId,
    int from,
    int to,
  ) async {
    final List<chat_app_api.ChatApp> chatMessagesApi =
        await _chatAppApi.getMessages(bearerToken, chatRoomId, from, to);
    final List<chat_message_repo.ChatMessage> chatMessagesRepo = chatMessagesApi
        .map((chatMessageApi) => chatMessageApi.toRepositoryChatMessage())
        .toList();
    return chatMessagesRepo;
  }

  Future<bool> sendMessage(
      String bearerToken, String chatRoomId, String content) async {
    return await _chatAppApi.sendMessage(bearerToken, chatRoomId, content);
  }
}

extension on chat_app_api.ChatApp {
  chat_message_repo.ChatMessage toRepositoryChatMessage() {
    final friend = chat_message_repo.ChatMessage(
      id: id,
      chatRoomId: chatRoomId,
      from: from,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    return friend;
  }
}
