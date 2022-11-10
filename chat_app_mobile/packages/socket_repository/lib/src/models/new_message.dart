import 'package:json_annotation/json_annotation.dart';

part 'new_message.g.dart';

@JsonSerializable()
class NewMessage {
  final String? chatRoomId;
  final String? from;
  final String? content;

  NewMessage({
    this.chatRoomId,
    this.from,
    this.content,
  });

  NewMessage copyWith({
    String? chatRoomId,
    String? from,
    String? content,
  }) =>
      NewMessage(
          chatRoomId: chatRoomId ?? this.chatRoomId,
          from: from ?? this.from,
          content: content ?? this.content);

  static final empty = NewMessage(chatRoomId: '');

  factory NewMessage.fromJson(Map<String, dynamic> json) =>
      _$NewMessageFromJson(json);

  Map<String, dynamic> toJson() => _$NewMessageToJson(this);
}
