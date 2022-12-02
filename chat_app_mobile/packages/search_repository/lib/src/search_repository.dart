import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

import '../search_repository.dart' as search_repository;

class SearchRepository {
  SearchRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<search_repository.Search> getSearch(
      String bearerToken, String input) async {
    final chat_app_api.Search searchApi =
        await _chatAppApi.getSearch(bearerToken, input);

    final search_repository.Search searchRepo = searchApi.toRepositorySearch();

    return searchRepo;
  }
}

extension on chat_app_api.Search {
  search_repository.Search toRepositorySearch() {
    final searchRes = search_repository.Search(
      users: users.map((user) => user.toRepositoryUser()),
      chatrooms: chatrooms.map((chatRoom) => chatRoom.toRepositoryChatRoom()),
      messages: messages.map((message) => message.toRepositoryChatMessage()),
    );
    return searchRes;
  }
}

extension on chat_app_api.Message {
  search_repository.Message toRepositoryChatMessage() {
    final user = search_repository.Message(
      id: id,
      chatRoomId: chatRoomId,
      from: from?.toRepositoryUser(),
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
    return user;
  }
}

extension on chat_app_api.ChatRoom {
  search_repository.ChatRoom toRepositoryChatRoom() {
    if (this == chat_app_api.ChatRoom.empty) {
      return search_repository.ChatRoom.empty;
    }
    final chatRoom = search_repository.ChatRoom(
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
      //friendsInChatRoom: members.map((member) => member.ui)
    );
    return chatRoom;
  }
}

extension on chat_app_api.User {
  search_repository.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return search_repository.User.empty;
    }
    final user = search_repository.User(
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
