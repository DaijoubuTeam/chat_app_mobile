import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_repository/socket_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.unAuthorized()) {
    on<AppLogOutRequested>(_onAppLogOutRequested);
    on<AppUserChanged>(_onAppUserChanged);
    _userSubscription =
        _authRepository.user.listen((user) => add(AppUserChanged(user)));
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onAppLogOutRequested(
      AppLogOutRequested event, Emitter<AppState> emit) async {
    // SocketApi.getDisconnect().listen((data) {
    //   print(data);
    // });
    await (_authRepository.logOut());
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    // SocketApi.getDisconnect().listen((data) {
    //   print(data);
    // });
    if (event.user != User.empty) {
      SocketApi.init();
      SocketApi.getRegister(event.user.uid);
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
