import 'package:json_annotation/json_annotation.dart';
import './models.dart';

part 'message_search.g.dart';

@JsonSerializable()
class MessageSearch {
  final String id;
  final ChatRoom? chatRoom;
  final User? from;
  final String? content;
  final String? type;
  final Iterable<User>? readed;
  final DateTime? createdAt;

  MessageSearch({
    required this.id,
    this.chatRoom,
    this.from,
    this.content,
    this.type,
    this.createdAt,
    Iterable<User>? readed,
  }) : readed = readed ?? List.unmodifiable([]);

  MessageSearch copyWith({
    String? id,
    ChatRoom? chatRoom,
    User? from,
    String? content,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<User>? readed,
  }) =>
      MessageSearch(
        id: id ?? this.id,
        chatRoom: chatRoom ?? this.chatRoom,
        from: from ?? this.from,
        content: content ?? this.content,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        readed: readed ?? this.readed,
      );

  static final empty = MessageSearch(id: '');

  factory MessageSearch.fromJson(Map<String, dynamic> json) =>
      _$MessageSearchFromJson(json);

  Map<String, dynamic> toJson() => _$MessageSearchToJson(this);
}
