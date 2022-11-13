import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import './models/models.dart' as message_model;

class MessageRepository {
  MessageRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<message_model.Message>> getMessages(
    String bearerToken,
    String uid,
    String chatRoomId,
    int from,
    int to,
  ) async {
    final List<chat_app_api.Message> chatMessagesApi =
        await _chatAppApi.getMessages(bearerToken, chatRoomId, from, to);

    final List<message_model.Message> chatMessagesRepo = chatMessagesApi
        .map((chatMessageApi) =>
            chatMessageApi.toRepositoryChatMessage().checkIsMe(uid))
        .toList();

    return chatMessagesRepo;
  }

  Future<bool> sendMessage(
      String bearerToken, String chatRoomId, String content) async {
    return await _chatAppApi.sendMessage(bearerToken, chatRoomId, content);
  }
}

extension on chat_app_api.Message {
  message_model.Message toRepositoryChatMessage() {
    final friend = message_model.Message(
      id: id,
      chatRoomId: chatRoomId,
      from: from?.toRepositoryUser(),
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    return friend;
  }
}

extension on chat_app_api.User {
  message_model.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return message_model.User.empty;
    }
    final user = message_model.User(
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

extension on message_model.Message {
  message_model.Message checkIsMe(String uid) {
    final uidOfUserMessage = from?.uid;
    final user = message_model.Message(
      id: id,
      chatRoomId: chatRoomId,
      from: from,
      isMe: uidOfUserMessage == uid,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      readed: readed,
    );
    return user;
  }
}
