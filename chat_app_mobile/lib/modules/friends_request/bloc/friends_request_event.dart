part of 'friends_request_bloc.dart';

abstract class FriendsRequestEvent extends Equatable {
  const FriendsRequestEvent();
  @override
  List<Object?> get props => [];
}

class FriendRequestInputSearchChanged extends FriendsRequestEvent {
  const FriendRequestInputSearchChanged(this.textInput);
  final String textInput;
  @override
  List<Object?> get props => [textInput];
}
