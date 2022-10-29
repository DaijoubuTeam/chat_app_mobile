part of 'friends_request_bloc.dart';

abstract class FriendsRequestState extends Equatable {
  const FriendsRequestState();

  @override
  List<Object?> get props => [];
}

class FriendsRequestInitial extends FriendsRequestState {}

class FriendsRequestGetListInProgress extends FriendsRequestState {}

class FriendsRequestGetListSuccess extends FriendsRequestState {
  const FriendsRequestGetListSuccess({required this.listFriendRequest});
  final List<friend_repository.Friend> listFriendRequest;

  @override
  List<Object?> get props => [listFriendRequest];
}

class FriendsRequestGetListFailure extends FriendsRequestState {}

class FriendsRequestCardActionSuccess extends FriendsRequestState {}

class FriendsRequestCardActionFailure extends FriendsRequestState {}
