part of 'call_bloc.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class CallInitial extends CallEvent {}

class CallInvited extends CallEvent {}

class CallWaitingStateChanged extends CallEvent {
  const CallWaitingStateChanged({this.status = false});
  final bool status;

  @override
  List<Object> get props => [status];
}

class CallAccepted extends CallEvent {}

class CallCanceled extends CallEvent {}
