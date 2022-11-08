part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEmailChanging extends LoginEvent {
  const LoginEmailChanging(this.email);

  final String? email;

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanging extends LoginEvent {
  const LoginPasswordChanging(this.password);

  final String? password;

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.email, this.password);

  final String? email;
  final String? password;

  @override
  List<Object?> get props => [email, password];
}

class LoginSubmitFailure extends LoginEvent {}

class LoginWithGoogleSubmitted extends LoginEvent {}
