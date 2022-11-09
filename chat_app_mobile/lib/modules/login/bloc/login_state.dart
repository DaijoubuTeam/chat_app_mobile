part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formzStatus = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzStatus formzStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password];
}

class LoginStateSubmitLoading extends LoginState {}

class LoginStateSubmitSuccess extends LoginState {}

class LoginStateSubmitFailure extends LoginState {}
