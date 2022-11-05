import 'package:chat_room_repository/src/models/models.dart'
    as chat_room_model_repo;
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class ChatRoomRepository {
  ChatRoomRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<chat_room_model_repo.ChatRoom>> getChatRoom(
      String bearerToken) async {
    final List<chat_app_api.ChatRoom> chatRoomsApi =
        await _chatAppApi.getChatRoom(bearerToken);
    final chatRoomsRepo = chatRoomsApi
        .map((chatRoomApi) => chatRoomApi.toRepositoryChatRoom())
        .toList();
    return chatRoomsRepo;
  }

  Future<bool> createNewChatRoom(
      String bearerToken, String chatRoomName) async {
    return await _chatAppApi.createNewChatRoom(bearerToken, chatRoomName);
  }

  Future<bool> updateChatRoom(
    String bearerToken,
    String chatRoomId,
    String chatRoomName,
    String chatRoomAvatar,
  ) async {
    return await _chatAppApi.updateChatRoom(
      bearerToken,
      chatRoomId,
      chatRoomName,
      chatRoomAvatar,
    );
  }

  Future<bool> deleteGroupChatRoom(
    String bearerToken,
    String chatRoomId,
  ) async {
    return await _chatAppApi.deleteGroupChatRoom(bearerToken, chatRoomId);
  }

  Future<bool> addMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatAppApi.addMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }

  Future<bool> deleteMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatAppApi.deleteMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }
}

extension on chat_app_api.ChatRoom {
  chat_room_model_repo.ChatRoom toRepositoryChatRoom() {
    if (this == chat_app_api.ChatRoom.empty) {
      return chat_room_model_repo.ChatRoom.empty;
    }
    final chatRoom = chat_room_model_repo.ChatRoom(
      chatRoomId: chatRoomId,
      chatRoomName: chatRoomName,
      chatRoomAvatar: chatRoomAvatar,
      type: type,
      members: members,
      admin: admin,
    );
    return chatRoom;
  }
}
