part of 'find_friend_bloc.dart';

class FindFriendState extends Equatable {
  const FindFriendState({this.inputSearch = ''});

  final String inputSearch;

  FindFriendState copyWith({String? inputSearch}) {
    return FindFriendState(
      inputSearch: inputSearch ?? this.inputSearch,
    );
  }

  @override
  List<Object> get props => [inputSearch];
}
