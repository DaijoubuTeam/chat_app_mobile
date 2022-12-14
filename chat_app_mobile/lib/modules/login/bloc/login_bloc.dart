import 'dart:async';

import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(const LoginState()) {
    on<LoginEmailChanging>(_onLoginEmailChanging);
    on<LoginPasswordChanging>(_onPasswordChanging);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGoogleSubmitted>(_onLoginWithGoogleSubmitted);
    on<LoginSubmitFailure>(_onLoginSubmitFailure);

    FlutterNativeSplash.remove();
  }

  final auth_repository.AuthRepository _authRepository;

  void _onLoginEmailChanging(
      LoginEmailChanging event, Emitter<LoginState> emit) {
    final email = event.email;
    if (email == null) {
      return;
    }
    emit(
      LoginState(
        email: Email.dirty(email),
        password: state.password,
        status: Formz.validate(
          [Email.dirty(email), state.password],
        ),
      ),
    );
  }

  void _onPasswordChanging(event, Emitter<LoginState> emit) {
    final password = event.password;
    if (password == null) {
      return;
    }
    emit(
      LoginState(
        email: state.email,
        password: Password.dirty(password),
        status: Formz.validate(
          [state.email, Password.dirty(password)],
        ),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      if (event.email.value == "" || event.password.value == "") {
        FlutterToastCustom.showToast("Email or password not empty", "warning");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        return;
      }
      if (event.email.invalid || event.password.invalid) {
        FlutterToastCustom.showToast("Email or password invalid", "warning");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        return;
      }
      await _authRepository.logInWithEmailAndPassword(
          email: event.email.value, password: event.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> _onLoginWithGoogleSubmitted(
      LoginWithGoogleSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await _authRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onLoginSubmitFailure(
      LoginSubmitFailure event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzStatus.submissionFailure));
  }
}
