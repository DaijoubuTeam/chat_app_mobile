import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
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
    final email = event.email;
    if (email == null) {
      return;
    }
    emit(
      LoginStateInitial(
        email: Email.dirty(email!),
        password: (state as LoginStateInitial).password,
        formzStatus: Formz.validate(
          [Email.dirty(email!), (state as LoginStateInitial).password],
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
      LoginStateInitial(
        email: (state as LoginStateInitial).email,
        password: Password.dirty(password!),
        formzStatus: Formz.validate(
          [(state as LoginStateInitial).email, Password.dirty(password!)],
        ),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(LoginStateSubmitLoading());
      if (event.email.invalid || event.password.invalid) {
        emit(const LoginStateInitial());
        return;
      }
      await _authRepository.logInWithEmailAndPassword(
          email: event.email.value!, password: event.password.value!);
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
