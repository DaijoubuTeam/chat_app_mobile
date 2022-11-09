import 'package:json_annotation/json_annotation.dart';

part 'chat_app.g.dart';

@JsonSerializable()
class ChatApp {
  final String id;
  final String chatRoomId;
  final String from;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatApp({
    required this.id,
    required this.chatRoomId,
    required this.from,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  ChatApp copyWith({
    String? id,
    String? chatRoomId,
    String? from,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChatApp(
        id: id ?? this.id,
        chatRoomId: chatRoomId ?? this.chatRoomId,
        from: from ?? this.from,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatApp.fromJson(Map<String, dynamic> json) =>
      _$ChatAppFromJson(json);

  Map<String, dynamic> toJson() => _$ChatAppToJson(this);
}
