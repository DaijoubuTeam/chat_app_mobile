part of 'call_bloc.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

//event sender
class CallInited extends CallEvent {}

class CallInvited extends CallEvent {}

class CallWaitingStateChanged extends CallEvent {
  const CallWaitingStateChanged({this.status = false});
  final bool status;

  @override
  List<Object> get props => [status];
}

class CallOfferReceived extends CallEvent {
  const CallOfferReceived({this.offer});
  final dynamic offer;

  @override
  List<Object> get props => [offer];
}

class CallCanceled extends CallEvent {}

//event receiver
class CallReceiverInited extends CallEvent {}

class CallCreateRoomSucceeded extends CallEvent {}

class CallCreateRoomFailed extends CallEvent {}
