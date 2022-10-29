part of 'find_friend_bloc.dart';

abstract class FindFriendState extends Equatable {
  const FindFriendState();
  @override
  List<Object?> get props => [];
}

class FindFriendInitial extends FindFriendState {}

class FindFriendInputChanging extends FindFriendState {
  const FindFriendInputChanging({required this.inputSearch});

  final String inputSearch;

  @override
  List<Object?> get props => [inputSearch];
}

class FindFriendSuccess extends FindFriendState {
  const FindFriendSuccess({required this.friendInfor});

  final user_repository.User friendInfor;

  @override
  List<Object?> get props => [friendInfor];
}

class FindFriendFailure extends FindFriendState {}
