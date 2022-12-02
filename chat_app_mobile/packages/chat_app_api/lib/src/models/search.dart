import './models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  final Iterable<User> users;
  final Iterable<ChatRoom> chatRooms;
  final Iterable<Message> messages;

  Search({
    Iterable<User>? users,
    Iterable<ChatRoom>? chatRooms,
    Iterable<Message>? messages,
  })  : users = users ?? List.unmodifiable([]),
        chatRooms = chatRooms ?? List.unmodifiable([]),
        messages = messages ?? List.unmodifiable([]);

  Search copyWith({
    List<User>? users,
    List<ChatRoom>? chatRooms,
    List<Message>? messages,
  }) =>
      Search(
        users: users ?? this.users,
        chatRooms: chatRooms ?? this.chatRooms,
        messages: messages ?? this.messages,
      );

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
