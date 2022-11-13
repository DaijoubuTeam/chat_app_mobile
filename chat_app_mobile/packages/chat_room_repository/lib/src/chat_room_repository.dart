import './models/models.dart' as chatroom_model;
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class ChatRoomRepository {
  ChatRoomRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<chatroom_model.ChatRoom>> getChatRoom(String bearerToken) async {
    final List<chat_app_api.ChatRoom> chatRoomsApi =
        await _chatAppApi.getChatRoom(bearerToken);

    final chatRoomsRepo = chatRoomsApi
        .map((chatRoomApi) => chatRoomApi.toRepositoryChatRoom())
        .toList();

    return chatRoomsRepo;
  }

  Future<chatroom_model.ChatRoom> getChatRoomById(
      String bearerToken, String id) async {
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

  Future<List<chatroom_model.ChatRoom>> getAllChatRoomRequest(
      String bearerToken) async {
    final List<chat_app_api.ChatRoom> chatRoomsApi =
        await _chatAppApi.getAllChatRoomRequest(bearerToken);

    final chatRoomsRepo = chatRoomsApi
        .map((chatRoomApi) => chatRoomApi.toRepositoryChatRoom())
        .toList();

    return chatRoomsRepo;
  }
}

extension on chat_app_api.ChatRoom {
  chatroom_model.ChatRoom toRepositoryChatRoom() {
    if (this == chat_app_api.ChatRoom.empty) {
      return chatroom_model.ChatRoom.empty;
    }
    final chatRoom = chatroom_model.ChatRoom(
      chatRoomId: chatRoomId,
      chatRoomName: chatRoomName,
      chatRoomAvatar: chatRoomAvatar,
      type: type,
      members: members.map((member) => member.toRepositoryUser()),
      admin: admin,
      fromLatestMessage: latestMessage?.from?.toRepositoryUser(),
      readedLatestMessage:
          latestMessage?.readed?.map((user) => user.toRepositoryUser()),
      contentLatestMessage: latestMessage?.content,
      latestTime: latestMessage?.createdAt,
    );
    return chatRoom;
  }
}

extension on chat_app_api.User {
  chatroom_model.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return chatroom_model.User.empty;
    }
    final user = chatroom_model.User(
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
