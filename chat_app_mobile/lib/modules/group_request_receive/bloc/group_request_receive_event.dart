part of 'group_request_receive_bloc.dart';

abstract class GroupRequestReceiveEvent extends Equatable {
  const GroupRequestReceiveEvent();
}

class GroupRequestReceiveInited extends GroupRequestReceiveEvent {
  @override
  List<Object?> get props => [];
}

class GroupRequestActionSubmitted extends GroupRequestReceiveEvent {
  const GroupRequestActionSubmitted(
      {required this.chatRoomId, required this.type});

  final String chatRoomId;
  final String type;

  @override
  List<Object?> get props => [chatRoomId, type];
}
