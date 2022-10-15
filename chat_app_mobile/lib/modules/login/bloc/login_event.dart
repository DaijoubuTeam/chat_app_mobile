part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginWithGoogleSubmitted extends LoginEvent {
  const LoginWithGoogleSubmitted();
}
