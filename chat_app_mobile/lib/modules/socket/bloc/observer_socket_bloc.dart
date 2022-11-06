import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:web_socket_repository/web_socket_repository.dart';

part 'observer_socket_event.dart';
part 'observer_socket_state.dart';

class ObserverSocketBloc
    extends Bloc<ObserverSocketEvent, ObserverSocketState> {
  ObserverSocketBloc(this._authRepository, this._socketRepository)
      : super(ObserverSocketInitial()) {
    on<ObserverSocketInited>(_onObserverSocketInited);
    on<ObserverSocketMessageSent>(_onObserverSocketMessageSent);

    add(ObserverSocketInited());
  }

  final WebSocketChannelRepository _socketRepository;
  final AuthRepository _authRepository;

  void _onObserverSocketInited(
      ObserverSocketInited event, Emitter<ObserverSocketState> emit) async {
    try {
      // SocketApi.getRegister(_authRepository.currentUser.uid).listen((data) {
      //   debugPrint(data);
      // });
    } catch (e) {
      log(e.toString(), name: "ObserverSocketInited");
    }
  }

  void _onObserverSocketMessageSent(
      ObserverSocketMessageSent event, Emitter<ObserverSocketState> emit) {
    try {
      // _socketRepository.socket.emit('new-message', {
      //   'chatRoomId': event.chatRoomId,
      //   'from': event.from,
      //   'content': event.content
      // });
      _socketRepository.socket.on('new-message', (data) {
        log(data.toString(), name: "new message data");
      });
    } catch (e) {
      log(e.toString(), name: "ObserverSocketMessageSent");
    }
  }
}
