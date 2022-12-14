import 'package:message_repository/message_repository.dart'
    as message_repository;
import '../models/models.dart' as chat_room_models;

class ChatRoom {
  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;
  final Iterable<chat_room_models.User> members;
  final Iterable<String> admin;
  final message_repository.Message? latestMessage;
  final String? type;
  //manage latest message
  final chat_room_models.User? fromLatestMessage;
  final Iterable<chat_room_models.User>? readedLatestMessage;
  final String? contentLatestMessage;
  final DateTime? latestTime;
  // add new property for handle UI
  final Iterable<chat_room_models.User> friendsInChatRoom;

  ChatRoom({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
    this.type,
    this.latestMessage,
    Iterable<chat_room_models.User>? members,
    Iterable<String>? admin,
    this.fromLatestMessage,
    Iterable<chat_room_models.User>? readedLatestMessage,
    this.contentLatestMessage,
    this.latestTime,
    Iterable<chat_room_models.User>? friendsInChatRoom,
  })  : members = members ?? List.unmodifiable([]),
        admin = admin ?? List.unmodifiable([]),
        readedLatestMessage = readedLatestMessage ?? List.unmodifiable([]),
        friendsInChatRoom = friendsInChatRoom ?? List.unmodifiable([]);

  ChatRoom copyWith({
    String? chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
    String? type,
    message_repository.Message? latestMessage,
    List<chat_room_models.User>? members,
    List<String>? admin,
    chat_room_models.User? fromLatestMessage,
    List<chat_room_models.User>? readedLatestMessage,
    String? contentLatestMessage,
    DateTime? latestTime,
    List<chat_room_models.User>? friendsInChatRoom,
  }) =>
      ChatRoom(
        chatRoomId: chatRoomId ?? this.chatRoomId,
        chatRoomName: chatRoomName ?? this.chatRoomName,
        chatRoomAvatar: chatRoomAvatar ?? this.chatRoomAvatar,
        type: type ?? this.type,
        latestMessage: latestMessage ?? this.latestMessage,
        members: members ?? this.members,
        admin: admin ?? this.admin,
        fromLatestMessage: fromLatestMessage ?? this.fromLatestMessage,
        readedLatestMessage: readedLatestMessage ?? this.readedLatestMessage,
        contentLatestMessage: contentLatestMessage ?? this.contentLatestMessage,
        latestTime: latestTime ?? this.latestTime,
        friendsInChatRoom: friendsInChatRoom ?? this.friendsInChatRoom,
      );

  static final empty = ChatRoom(chatRoomId: '');
}
