part of 'friend_profile_bloc.dart';

abstract class FriendProfileState extends Equatable {
  const FriendProfileState();

  @override
  List<Object?> get props => [];
}

class FriendProfileInitial extends FriendProfileState {
  const FriendProfileInitial({required this.friendId});

  final String friendId;

  @override
  List<Object?> get props => [friendId];
}

class FriendProfileGetInforSuccess extends FriendProfileState {
  const FriendProfileGetInforSuccess({
    required this.friendInfor,
    this.isSentRequest = false,
  });

  final user_repository.User friendInfor;
  final bool isSentRequest;

  @override
  List<Object?> get props => [friendInfor];
}

class FriendProfileGetInforInLoad extends FriendProfileState {}

class FriendProfileGetInforFailure extends FriendProfileState {}

class FriendProfileSentFriendSuccess extends FriendProfileState {}
