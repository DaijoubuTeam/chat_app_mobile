import 'chat_room.dart';
import 'user.dart';

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
}
