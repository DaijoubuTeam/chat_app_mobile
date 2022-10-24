part of 'friends_request_bloc.dart';

class FriendsRequestState extends Equatable {
  const FriendsRequestState({this.inputSearch = ''});

  final String inputSearch;

  FriendsRequestState copyWith({String? inputSearch}) {
    return FriendsRequestState(
      inputSearch: inputSearch ?? this.inputSearch,
    );
  }

  @override
  List<Object?> get props => [inputSearch];
}
