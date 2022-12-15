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

class CallMissed extends CallEvent {}

class CallCameraStatusChanged extends CallEvent {
  const CallCameraStatusChanged({required this.isCameraOpen});
  final bool isCameraOpen;

  @override
  List<Object> get props => [isCameraOpen];
}

class CallMicStatusChanged extends CallEvent {
  const CallMicStatusChanged({required this.isMicOpen});
  final bool isMicOpen;

  @override
  List<Object> get props => [isMicOpen];
}

//event receiver
class CallReceiverInited extends CallEvent {}

class CallCreateRoomSucceeded extends CallEvent {}

class CallCreateRoomFailed extends CallEvent {}

class CallRemoteCameraStatusChanged extends CallEvent {
  const CallRemoteCameraStatusChanged({required this.isRemoteCameraOpen});
  final bool isRemoteCameraOpen;

  @override
  List<Object> get props => [isRemoteCameraOpen];
}
