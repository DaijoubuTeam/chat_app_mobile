part of 'find_friend_bloc.dart';

abstract class FindFriendEvent extends Equatable {
  const FindFriendEvent();

  @override
  List<Object?> get props => [];
}

class FindFriendInputSearchChanged extends FindFriendEvent {
  const FindFriendInputSearchChanged(this.textInput);
  final String textInput;

  @override
  List<Object?> get props => [textInput];
}
