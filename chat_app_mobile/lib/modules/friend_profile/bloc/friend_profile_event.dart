part of 'friend_profile_bloc.dart';

abstract class FriendProfileEvent extends Equatable {
  const FriendProfileEvent();

  @override
  List<Object> get props => [];
}

class FriendProfilePageInited extends FriendProfileEvent {}

class FriendProfileButtonSubmitted extends FriendProfileEvent {}
