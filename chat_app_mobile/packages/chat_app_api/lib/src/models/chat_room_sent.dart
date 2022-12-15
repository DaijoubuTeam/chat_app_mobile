import 'package:json_annotation/json_annotation.dart';
import './models.dart';

part 'chat_room_sent.g.dart';

@JsonSerializable()
class ChatRoomSent {
  final ChatRoom? chatRoom;
  final User? to;

  ChatRoomSent({
    this.chatRoom,
    this.to,
  });

  ChatRoomSent copyWith({
    ChatRoom? chatRoom,
    User? to,
  }) =>
      ChatRoomSent(
        chatRoom: chatRoom ?? this.chatRoom,
        to: to ?? this.to,
      );

  factory ChatRoomSent.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomSentFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomSentToJson(this);
}
