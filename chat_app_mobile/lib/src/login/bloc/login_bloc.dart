import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGoogleSubmitted>(_onLoginWithGoogleSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(event.email.isNotEmpty
        ? state.copyWith(email: event.email)
        : state.copyWith(email: ''));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(event.password.isNotEmpty
        ? state.copyWith(password: event.password)
        : state.copyWith(password: ''));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
    } catch (err) {
      log(err.toString(), name: 'on login submitted error');
    }
  }

  Future<void> _onLoginWithGoogleSubmitted(
      LoginWithGoogleSubmitted event, Emitter<LoginState> emit) async {
    try {
      await _authRepository.logInWithGoogle();
    } catch (err) {
      log(err.toString(), name: 'on login with google submitted error');
    }
  }
}
