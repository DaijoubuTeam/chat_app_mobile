import 'package:json_annotation/json_annotation.dart';
import './models.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;
  final Iterable<User> members;
  final Iterable<String> admin;
  final NewMessage? latestMessage;
  final String? type;

  ChatRoom({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
    this.type,
    this.latestMessage,
    Iterable<User>? members,
    Iterable<String>? admin,
  })  : members = members ?? List.unmodifiable([]),
        admin = admin ?? List.unmodifiable([]);

  ChatRoom copyWith({
    String? chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
    String? type,
    NewMessage? latestMessage,
    List<User>? members,
    List<String>? admin,
  }) =>
      ChatRoom(
        chatRoomId: chatRoomId ?? this.chatRoomId,
        chatRoomName: chatRoomName ?? this.chatRoomName,
        chatRoomAvatar: chatRoomAvatar ?? this.chatRoomAvatar,
        type: type ?? this.type,
        latestMessage: latestMessage ?? this.latestMessage,
        members: members ?? this.members,
        admin: admin ?? this.admin,
      );

  static final empty = ChatRoom(chatRoomId: '');

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
