part of 'group_request_receive_bloc.dart';

abstract class GroupRequestReceiveEvent extends Equatable {
  const GroupRequestReceiveEvent();
}

class GroupRequestReceiveInited extends GroupRequestReceiveEvent {
  @override
  List<Object?> get props => [];
}
