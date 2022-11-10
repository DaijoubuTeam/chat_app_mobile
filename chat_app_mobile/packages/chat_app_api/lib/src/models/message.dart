import './user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String? chatRoomId;
  final User? from;
  final String? content;
  final Iterable<User>? readed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    required this.id,
    this.chatRoomId,
    this.from,
    this.content,
    this.createdAt,
    this.updatedAt,
    Iterable<User>? readed,
  }) : readed = readed ?? List.unmodifiable([]);

  Message copyWith({
    String? id,
    String? chatRoomId,
    User? from,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<User>? readed,
  }) =>
      Message(
        id: id ?? this.id,
        chatRoomId: chatRoomId ?? this.chatRoomId,
        from: from ?? this.from,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        readed: readed ?? this.readed,
      );

  static final empty = Message(id: '');

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
