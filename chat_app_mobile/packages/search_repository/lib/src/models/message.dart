import 'package:search_repository/search_repository.dart';

class Message {
  final String id;
  //final String? chatRoomId;
  final ChatRoom? chatRoom;
  final User? from;
  final bool? isMe;
  final String? content;
  final Iterable<User>? readed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    required this.id,
    this.chatRoom,
    this.from,
    this.isMe,
    this.content,
    this.createdAt,
    this.updatedAt,
    Iterable<User>? readed,
  }) : readed = readed ?? List.unmodifiable([]);

  Message copyWith({
    String? id,
    String? chatRoomId,
    User? from,
    bool? isMe,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<User>? readed,
    ChatRoom? chatRoom,
  }) =>
      Message(
        id: id ?? this.id,
        chatRoom: chatRoom ?? this.chatRoom,
        from: from ?? this.from,
        isMe: isMe ?? this.isMe,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        readed: readed ?? this.readed,
      );

  static final empty = Message(id: '');
}
