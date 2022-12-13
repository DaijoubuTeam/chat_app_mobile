import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:socket_repository/socket_repository.dart';

import '../../../services/webrtc/signaling.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc({required friendId, required this.authRepository})
      : super(CallState(friendId: friendId)) {
    on<CallInitial>(_onCallInitial);
    //on<CallInvited>(_onCallInvited);
    //on<CallWaitingStateChanged>(_onCallWaitingStateChanged);
    on<CallAccepted>(_onCallAccepted);
    on<CallCanceled>(_onCallCanceled);
    socketSubscription = SocketAPI.socketApi.webRTCStream.stream.listen((data) {
      if (data["data"]["type"] == "reject") {
        add(CallCanceled());
      }
      if (data["data"]["type"] == "accept") {
        add(CallAccepted());
      }
    });

    add(CallInitial());
  }

  CallBloc.invited({required friendId, required this.authRepository})
      : super(CallState(friendId: friendId));

  late final StreamSubscription<dynamic> socketSubscription;
  final auth_repo.AuthRepository authRepository;

  Future<void> _onCallInitial(
      CallInitial event, Emitter<CallState> emit) async {
    final bearerToken = await authRepository.bearToken;
    if (bearerToken != null) {
      Signaling().inviteCall(bearerToken, state.friendId);
      emit(state.copyWith(isWaiting: true));
    }
  }

  // Future<void> _onCallInvited(
  //     CallInvited event, Emitter<CallState> emit) async {
  //   final bearerToken = await authRepository.bearToken;
  //   if (bearerToken != null) {
  //     Signaling().inviteCall(bearerToken, state.friendId);
  //     emit(state.copyWith(isWaiting: true));
  //   }
  // }

  // void _onCallWaitingStateChanged(
  //     CallWaitingStateChanged event, Emitter<CallState> emit) {
  //   emit(state.copyWith(isWaiting: event.status));
  // }

  void _onCallAccepted(CallAccepted event, Emitter<CallState> emit) async {
    emit(state.copyWith(isWaiting: false, isCancel: false));
  }

  void _onCallCanceled(CallCanceled event, Emitter<CallState> emit) {
    emit(state.copyWith(isWaiting: false, isCancel: true));
  }

  @override
  Future<void> close() {
    socketSubscription.cancel();
    return super.close();
  }
}
