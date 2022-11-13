import './models/models.dart';
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class ChatRoomRepository {
  ChatRoomRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<ChatRoom>> getChatRoom(String bearerToken) async {
    final List<chat_app_api.ChatRoom> chatRoomsApi =
        await _chatAppApi.getChatRoom(bearerToken);

    final chatRoomsRepo = chatRoomsApi
        .map((chatRoomApi) => chatRoomApi.toRepositoryChatRoom())
        .toList();

    return chatRoomsRepo;
  }

  Future<ChatRoom> getChatRoomById(String bearerToken, String id) async {
    final chat_app_api.ChatRoom chatRoomApi =
        await _chatAppApi.getChatRoomById(bearerToken, id);

    final chatRoomRepo = chatRoomApi.toRepositoryChatRoom();

    return chatRoomRepo;
  }

  Future<bool> createNewChatRoom(
      String bearerToken, String chatRoomName) async {
    return await _chatAppApi.createNewChatRoom(bearerToken, chatRoomName);
  }

  Future<bool> acceptJoinChat(String bearerToken, String chatRoomId) async {
    return await _chatAppApi.acceptJoinChat(bearerToken, chatRoomId);
  }

  Future<bool> rejectJoinChat(String bearerToken, String chatRoomId) async {
    return await _chatAppApi.rejectJoinChat(bearerToken, chatRoomId);
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

  Future<bool> inviteMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatAppApi.inviteMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }

  Future<bool> removeMemberChatRoom(
    String bearerToken,
    String chatRoomId,
    String memberId,
  ) async {
    return await _chatAppApi.removeMemberChatRoom(
        bearerToken, chatRoomId, memberId);
  }

  Future<List<ChatRoom>> getAllChatRoomRequest(String bearerToken) async {
    final List<chat_app_api.ChatRoom> chatRoomsApi =
        await _chatAppApi.getAllChatRoomRequest(bearerToken);

    final chatRoomsRepo = chatRoomsApi
        .map((chatRoomApi) => chatRoomApi.toRepositoryChatRoom())
        .toList();

    return chatRoomsRepo;
  }
}

extension on chat_app_api.ChatRoom {
  ChatRoom toRepositoryChatRoom() {
    if (this == chat_app_api.ChatRoom.empty) {
      return ChatRoom.empty;
    }
    final chatRoom = ChatRoom(
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
