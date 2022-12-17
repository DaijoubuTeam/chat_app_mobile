part of 'friend_profile_bloc.dart';

abstract class FriendProfileState extends Equatable {
  const FriendProfileState();

  @override
  List<Object?> get props => [];
}

class FriendProfileInitial extends FriendProfileState {
  const FriendProfileInitial({required this.friendInfor});

  final user_repository.User friendInfor;

  @override
  List<Object?> get props => [friendInfor];
}
