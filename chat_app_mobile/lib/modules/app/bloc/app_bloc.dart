import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_repository/socket_repository.dart' as socket_repo;

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.unAuthorized()) {
    on<AppLogOutRequested>(_onAppLogOutRequested);
    on<AppUserChanged>(_onAppUserChanged);
    _userSubscription = _authRepository.user.listen((user) {
      add(AppUserChanged(user));
    });
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  User get authCurrentUser => _authRepository.currentUser;

  Future<void> _onAppLogOutRequested(
      AppLogOutRequested event, Emitter<AppState> emit) async {
    await (_authRepository.logOut());
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    socket_repo.SocketAPI.SocketApi.socketDisconnected();
    socket_repo.SocketAPI.SocketApi.socketConnect().onConnect((data) {
      if (event.user != User.empty) {
        log(_authRepository.currentUser.uid);
        socket_repo.SocketAPI.SocketApi
            .socketRegister(_authRepository.currentUser.uid);
      }
    });
    if (event.user != User.empty) {
      emit(const AppState.authorized());
    } else {
      emit(const AppState.unAuthorized());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
