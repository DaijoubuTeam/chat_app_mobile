part of 'group_request_receive_bloc.dart';

abstract class GroupRequestReceiveEvent extends Equatable {
  const GroupRequestReceiveEvent();

  @override
  List<Object?> get props => [];
}

class GroupRequestReceiveInited extends GroupRequestReceiveEvent {}

class GroupRequestReceiveRefreshed extends GroupRequestReceiveEvent {}

class GroupRequestActionSubmitted extends GroupRequestReceiveEvent {
  const GroupRequestActionSubmitted(
      {required this.chatRoomId, required this.type});

  final String chatRoomId;
  final String type;

  @override
  List<Object?> get props => [chatRoomId, type];
}
