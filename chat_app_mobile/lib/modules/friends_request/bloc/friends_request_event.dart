part of 'friends_request_bloc.dart';

abstract class FriendsRequestEvent extends Equatable {
  const FriendsRequestEvent();
  @override
  List<Object?> get props => [];
}

class FriendRequestPageInited extends FriendsRequestEvent {
  const FriendRequestPageInited();
}

class FriendRequestPageLoading extends FriendsRequestEvent {
  const FriendRequestPageLoading();
}
