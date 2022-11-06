import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(event.email.isNotEmpty
        ? state.copyWith(email: event.email)
        : state.copyWith(email: ''));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(event.password.isNotEmpty
        ? state.copyWith(password: event.password)
        : state.copyWith(password: ''));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(event.confirmPassword.isNotEmpty
        ? state.copyWith(confirmPassword: event.confirmPassword)
        : state.copyWith(confirmPassword: ''));
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      sleep(Duration(milliseconds: 100));
      print("rong");
    } else {
      sleep(Duration(milliseconds: 100));
      print("khong rong");
    }
  }
}
