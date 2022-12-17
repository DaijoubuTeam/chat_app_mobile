part of 'friend_request_sent_bloc.dart';

abstract class FriendRequestSentEvent extends Equatable {
  const FriendRequestSentEvent();

  @override
  List<Object?> get props => [];
}

class FriendRequestSentInited extends FriendRequestSentEvent {}

class FriendRequestCardSubmitted extends FriendRequestSentEvent {
  const FriendRequestCardSubmitted({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
