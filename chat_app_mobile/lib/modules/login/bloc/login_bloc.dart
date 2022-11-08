import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(const LoginStateInitial()) {
    on<LoginEmailChanging>(_onLoginEmailChanging);
    on<LoginPasswordChanging>(_onPasswordChanging);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGoogleSubmitted>(_onLoginWithGoogleSubmitted);
    on<LoginSubmitFailure>(_onLoginSubmitFailure);
  }

  final auth_repository.AuthRepository _authRepository;

  void _onLoginEmailChanging(
      LoginEmailChanging event, Emitter<LoginState> emit) {
    emit(
      LoginStateInitial(
          email: event.email, password: (state as LoginStateInitial).password),
    );
  }

  void _onPasswordChanging(event, Emitter<LoginState> emit) {
    emit(
      LoginStateInitial(
          email: (state as LoginStateInitial).email, password: event.password),
    );
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(LoginStateSubmitLoading());
      if (event.email == null || event.password == null) {
        emit(LoginStateSubmitFailure());
        emit(const LoginStateInitial());
        return;
      }
      await _authRepository.logInWithEmailAndPassword(
          email: event.email!, password: event.password!);
      emit(LoginStateSubmitSuccess());
    } catch (err) {
      log(err.toString(), name: 'on login submitted error');
      emit(LoginStateSubmitFailure());
    }
  }

  Future<void> _onLoginWithGoogleSubmitted(
      LoginWithGoogleSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(LoginStateSubmitLoading());
      await _authRepository.logInWithGoogle();
      emit(LoginStateSubmitSuccess());
    } catch (err) {
      log(err.toString(), name: 'on login with google submitted error');
      emit(LoginStateSubmitFailure());
    }
  }

  void _onLoginSubmitFailure(
      LoginSubmitFailure event, Emitter<LoginState> emit) {
    emit(const LoginStateInitial());
  }
}
