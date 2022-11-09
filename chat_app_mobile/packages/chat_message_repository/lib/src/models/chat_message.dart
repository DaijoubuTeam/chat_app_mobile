class ChatMessage {
  final String id;
  final String chatRoomId;
  final String from;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.chatRoomId,
    required this.from,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.isMe,
  });

  ChatMessage copyWith({
    String? id,
    String? chatRoomId,
    String? from,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isMe,
  }) =>
      ChatMessage(
          id: id ?? this.id,
          chatRoomId: chatRoomId ?? this.chatRoomId,
          from: from ?? this.from,
          content: content ?? this.content,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          isMe: isMe ?? this.isMe);
}
