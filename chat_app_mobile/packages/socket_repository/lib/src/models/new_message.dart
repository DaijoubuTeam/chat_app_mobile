import 'package:json_annotation/json_annotation.dart';
import './user.dart';

part 'new_message.g.dart';

@JsonSerializable()
class NewMessage {
  final String id;
  final String? chatRoomId;
  final User? from;
  final bool? isMe;
  final String? content;
  final Iterable<User>? readed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewMessage({
    required this.id,
    this.chatRoomId,
    this.from,
    this.isMe,
    this.content,
    this.createdAt,
    this.updatedAt,
    Iterable<User>? readed,
  }) : readed = readed ?? List.unmodifiable([]);

  NewMessage copyWith({
    String? id,
    String? chatRoomId,
    User? from,
    bool? isMe,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<User>? readed,
  }) =>
      NewMessage(
        id: id ?? this.id,
        chatRoomId: chatRoomId ?? this.chatRoomId,
        from: from ?? this.from,
        isMe: isMe ?? this.isMe,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        readed: readed ?? this.readed,
      );

  static final empty = NewMessage(id: '');

  factory NewMessage.fromJson(Map<String, dynamic> json) =>
      _$NewMessageFromJson(json);

  Map<String, dynamic> toJson() => _$NewMessageToJson(this);
}
