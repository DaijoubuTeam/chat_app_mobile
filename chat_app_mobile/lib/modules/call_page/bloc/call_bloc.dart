import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:socket_repository/socket_repository.dart';

import '../../../services/webrtc/signaling.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc(
      {required friendId, required isReceiver, required this.authRepository})
      : super(CallState(
          friendId: friendId,
          isReceiver: isReceiver,
        )) {
    on<CallInited>(_onCallInited);
    on<CallOfferReceived>(_onCallOfferReceived);
    on<CallCanceled>(_onCallCanceled);
    on<CallCameraStatusChanged>(_onCallCameraStatusChanged);
    on<CallMicStatusChanged>(_onCallMicStatusChanged);

    socketSubscription = SocketAPI.socketApi.webRTCStream.stream.listen((data) {
      if (data["data"]["type"] == "reject") {
        add(CallCanceled());
      }
      if (data["data"]["type"] == "offer") {
        add(CallOfferReceived(offer: data["data"]));
      }
    });

    add(CallInited());
  }

  CallBloc.invited(
      {required friendId, required isReceiver, required this.authRepository})
      : super(CallState(
          friendId: friendId,
          isReceiver: isReceiver,
        )) {
    on<CallReceiverInited>(_onCallReceiverInited);
    on<CallCreateRoomSucceeded>(_onCallCreateRoomSucceeded);
    on<CallCreateRoomFailed>(_onCallCreateRoomFailed);
    on<CallRemoteCameraStatusChanged>(_onCallRemoteCameraStatusChanged);

    socketSubscription =
        SocketAPI.socketApi.webRTCStream.stream.listen((data) {});

    add(CallReceiverInited());
  }

  late final StreamSubscription<dynamic> socketSubscription;
  final auth_repo.AuthRepository authRepository;

  Future<void> _onCallInited(CallInited event, Emitter<CallState> emit) async {
    final bearerToken = await authRepository.bearToken;
    if (bearerToken != null) {
      Signaling().inviteCall(bearerToken, state.friendId);
    }
    emit(state.copyWith(isWaiting: true));
  }

  Future<void> _onCallReceiverInited(
      CallReceiverInited event, Emitter<CallState> emit) async {
    emit(state.copyWith(isWaiting: true));
  }

  void _onCallOfferReceived(CallOfferReceived event, Emitter<CallState> emit) {
    emit(state.copyWith(offer: event.offer, isWaiting: false, isCancel: false));
  }

  void _onCallCanceled(CallCanceled event, Emitter<CallState> emit) {
    emit(state.copyWith(isWaiting: false, isCancel: true));
  }

  void _onCallCameraStatusChanged(
      CallCameraStatusChanged event, Emitter<CallState> emit) {
    emit(state.copyWith(isCameraOpen: event.isCameraOpen));
  }

  void _onCallMicStatusChanged(
      CallMicStatusChanged event, Emitter<CallState> emit) {
    emit(state.copyWith(isMicOpen: event.isMicOpen));
  }

  @override
  Future<void> close() {
    socketSubscription.cancel();
    return super.close();
  }

  void _onCallCreateRoomSucceeded(
      CallCreateRoomSucceeded event, Emitter<CallState> emit) {
    emit(state.copyWith(isWaiting: false, isCancel: false));
  }

  void _onCallCreateRoomFailed(
      CallCreateRoomFailed event, Emitter<CallState> emit) {
    emit(state.copyWith(isWaiting: false, isCancel: true));
  }

  void _onCallRemoteCameraStatusChanged(
      CallRemoteCameraStatusChanged event, Emitter<CallState> emit) {
    emit(state.copyWith(isRemoteCameraOpen: event.isRemoteCameraOpen));
  }
}
