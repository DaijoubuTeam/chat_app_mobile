part of 'friends_request_bloc.dart';

abstract class FriendsRequestEvent extends Equatable {
  const FriendsRequestEvent();
  @override
  List<Object?> get props => [];
}

class FriendRequestPageInited extends FriendsRequestEvent {
  const FriendRequestPageInited();
}

class FriendRequestCardAction extends FriendsRequestEvent {
  const FriendRequestCardAction({required this.id, required this.action});

  final String id;
  final String action;
  @override
  List<Object?> get props => [id, action];
}
