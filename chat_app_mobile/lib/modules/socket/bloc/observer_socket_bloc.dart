import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_repository/web_socket_repository.dart';

part 'observer_socket_event.dart';
part 'observer_socket_state.dart';

class ObserverSocketBloc
    extends Bloc<ObserverSocketEvent, ObserverSocketState> {
  ObserverSocketBloc(this._authRepository, this._socketRepository)
      : super(ObserverSocketInitial()) {
    on<ObserverSocketInited>(_onObserverSocketInited);

    add(ObserverSocketInited());
  }

  final WebSocketChannelRepository _socketRepository;
  final AuthRepository _authRepository;

  Future<void> _onObserverSocketInited(
      ObserverSocketInited event, Emitter<ObserverSocketState> emit) async {
    try {
      _socketRepository.socket
          .emit('register', {'uid': _authRepository.currentUser.uid});
      _socketRepository.socket.on('register', (data) {
        log(data.toString(), name: "register data");
      });
    } catch (e) {
      log(e.toString(), name: "inited socket");
    }
    return;
  }
}
