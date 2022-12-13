import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import "package:auth_repository/auth_repository.dart";
import "package:webrtc_repository/webrtc_repository.dart";

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.authRepository, this.webRTCRepostiory)
      : super(const HomeState()) {
    on<SelectTabIndexChanged>(_onSelecTabIndexChanged);
    on<SelectActionCallReject>(_onSelectActionCallReject);
  }

  final AuthRepository authRepository;
  final WebRTCRepostiory webRTCRepostiory;

  void _onSelecTabIndexChanged(
      SelectTabIndexChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }

  Future<void> _onSelectActionCallReject(
      SelectActionCallReject event, Emitter<HomeState> emit) async {
    try {
      final bearerToken = await authRepository.bearToken;
      if (bearerToken != null) {
        final newData = {"type": "reject"};
        webRTCRepostiory.postWebRTC(bearerToken, event.friendId, newData);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
