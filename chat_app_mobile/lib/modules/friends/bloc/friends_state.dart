part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsGetListInProgress extends FriendsState {}

class FriendsGetListSuccess extends FriendsState {
  const FriendsGetListSuccess({
    required this.listFriend,
    this.numberRequestFriend = 0,
  });

  final List<friend_repository.User> listFriend;
  final int numberRequestFriend;

  @override
  List<Object> get props => [listFriend, numberRequestFriend];
}

class FriendsGetListFailure extends FriendsState {}
