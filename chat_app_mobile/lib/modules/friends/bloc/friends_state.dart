part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsGetListInProgress extends FriendsState {}

class FriendsGetListSuccess extends FriendsState {
  const FriendsGetListSuccess({required this.listFriend});

  final List<friend_repository.Friend> listFriend;

  @override
  List<Object> get props => [listFriend];
}

class FriendsGetListFailure extends FriendsState {}
