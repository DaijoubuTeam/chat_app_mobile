part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends SignUpEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends SignUpEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  const ConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;

  @override
  List<Object?> get props => [confirmPassword];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}