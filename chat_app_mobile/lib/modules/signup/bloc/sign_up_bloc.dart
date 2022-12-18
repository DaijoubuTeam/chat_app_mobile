import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._authRepository) : super(const SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  final auth_repository.AuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final email = event.email;
    if (email == null) {
      return;
    }
    emit(state.copyWith(
      email: Email.dirty(email),
      password: state.password,
      confirmPassword: state.confirmPassword,
      status: Formz.validate(
        [
          Email.dirty(email),
          state.password,
          state.confirmPassword,
        ],
      ),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final password = event.password;
    if (password == null) {
      return;
    }
    emit(state.copyWith(
      email: state.email,
      password: Password.dirty(password),
      confirmPassword: state.confirmPassword,
      status: Formz.validate(
        [
          state.email,
          Password.dirty(password),
          state.confirmPassword,
        ],
      ),
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    final confirmPassword = event.confirmPassword;
    if (confirmPassword == null) {
      return;
    }
    emit(state.copyWith(
      email: state.email,
      password: state.password,
      confirmPassword: ConfirmedPassword.dirty(
        password: state.password.value,
        value: confirmPassword,
      ),
      status: Formz.validate(
        [
          state.email,
          state.password,
          ConfirmedPassword.dirty(
            password: state.password.value,
            value: confirmPassword,
          ),
        ],
      ),
    ));
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      if (state.email.invalid ||
          state.password.invalid ||
          state.confirmPassword.invalid) {
        return;
      }
      await _authRepository.createUserWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlutterToastCustom.showToast(
            'The password provided is too weak.', 'error');
      } else if (e.code == 'email-already-in-use') {
        FlutterToastCustom.showToast(
            'The account already exists for that email.', 'error');
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
