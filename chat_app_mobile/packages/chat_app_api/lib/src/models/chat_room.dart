import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;
  final String? type;
  final Iterable<String>? members;
  final Iterable<String>? admin;

  ChatRoom({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
    this.type,
    Iterable<String>? members,
    Iterable<String>? admin,
  })  : members = members ?? List.unmodifiable([]),
        admin = admin ?? List.unmodifiable([]);

  ChatRoom copyWith({
    String? chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
    String? type,
    Iterable<String>? members,
    Iterable<String>? admin,
  }) =>
      ChatRoom(
        chatRoomId: chatRoomId ?? this.chatRoomId,
        chatRoomName: chatRoomName ?? this.chatRoomName,
        chatRoomAvatar: chatRoomAvatar ?? this.chatRoomAvatar,
        type: type ?? this.type,
        members: members ?? this.members,
        admin: admin ?? this.admin,
      );

  static final empty = ChatRoom(chatRoomId: '');

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
