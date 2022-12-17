part of 'friend_request_sent_bloc.dart';

class FriendRequestSentState extends Equatable {
  const FriendRequestSentState();

  @override
  List<Object?> get props => [];
}

class FriendRequestSentGetListLoading extends FriendRequestSentState {}

class FriendRequestSentGetListFailure extends FriendRequestSentState {}

class FriendRequestSentGetListSuccess extends FriendRequestSentState {
  const FriendRequestSentGetListSuccess({required this.listFriendRequestSent});

  final List<friend_repository.User> listFriendRequestSent;

  @override
  List<Object?> get props => [listFriendRequestSent];
}
