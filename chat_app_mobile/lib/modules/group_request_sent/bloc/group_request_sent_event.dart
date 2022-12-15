part of 'group_request_sent_bloc.dart';

abstract class GroupRequestSentEvent extends Equatable {
  const GroupRequestSentEvent();

  @override
  List<Object?> get props => [];
}

class GroupRequestSentInited extends GroupRequestSentEvent {}

class GroupRequestSentSubmitted extends GroupRequestSentEvent {
  const GroupRequestSentSubmitted(
      {required this.chatRoomId, required this.friendId});

  final String chatRoomId;
  final String friendId;

  @override
  List<Object?> get props => [chatRoomId, friendId];
}
