part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({this.users, this.chatrooms, this.messages});

  final List<search_repo.User>? users;
  final List<search_repo.ChatRoom>? chatrooms;
  final List<search_repo.Message>? messages;

  SearchState copyWith({
    List<search_repo.User>? users,
    List<search_repo.ChatRoom>? chatrooms,
    List<search_repo.Message>? messages,
  }) {
    return SearchState(
      users: users ?? this.users,
      chatrooms: chatrooms ?? this.chatrooms,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [users, chatrooms, messages];
}
