part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial({this.email, this.password});
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [email, password];
}

class LoginStateSubmitLoading extends LoginState {}

class LoginStateSubmitSuccess extends LoginState {}

class LoginStateSubmitFailure extends LoginState {}
