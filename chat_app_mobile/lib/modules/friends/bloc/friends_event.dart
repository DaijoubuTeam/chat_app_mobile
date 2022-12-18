part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class FriendsInited extends FriendsEvent {
  const FriendsInited();
}

class FriendsDeleted extends FriendsEvent {
  const FriendsDeleted({required this.friendId});

  final String friendId;

  @override
  List<Object?> get props => [friendId];
}
