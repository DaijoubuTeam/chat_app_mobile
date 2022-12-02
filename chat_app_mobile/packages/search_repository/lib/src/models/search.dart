import '../../search_repository.dart';

class Search {
  final Iterable<User> users;
  final Iterable<ChatRoom> chatrooms;
  final Iterable<Message> messages;

  Search({
    Iterable<User>? users,
    Iterable<ChatRoom>? chatrooms,
    Iterable<Message>? messages,
  })  : users = users ?? List.unmodifiable([]),
        chatrooms = chatrooms ?? List.unmodifiable([]),
        messages = messages ?? List.unmodifiable([]);

  Search copyWith({
    List<User>? users,
    List<ChatRoom>? chatrooms,
    List<Message>? messages,
  }) =>
      Search(
        users: users ?? this.users,
        chatrooms: chatrooms ?? this.chatrooms,
        messages: messages ?? this.messages,
      );
}
