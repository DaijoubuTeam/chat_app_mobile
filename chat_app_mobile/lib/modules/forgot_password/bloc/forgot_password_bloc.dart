import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../common/widgets/toasts/flutter_toast.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanging>(_onForgotPasswordEmailChanging);
    on<ForgotPasswordButtonSubmitted>(_onForgotPasswordButtonSubmmitted);
  }

  final AuthRepository _authRepository;

  void _onForgotPasswordEmailChanging(ForgotPasswordEmailChanging event,
      Emitter<ForgotPasswordState> emit) async {
    final email = event.email;
    if (email == null) {
      return;
    }

    emit(
      state.copyWith(
        email: Email.dirty(email),
        status: Formz.validate([Email.dirty(email)]),
      ),
    );
  }

  Future<void> _onForgotPasswordButtonSubmmitted(
      ForgotPasswordButtonSubmitted event,
      Emitter<ForgotPasswordState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      if (state.email.invalid) {
        return;
      }
      await _authRepository.forgotPassword(state.email.value);
      FlutterToastCustom.showToast(
          "Send reset password email success", "success");
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      FlutterToastCustom.showToast("Send reset password email fail", "error");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
