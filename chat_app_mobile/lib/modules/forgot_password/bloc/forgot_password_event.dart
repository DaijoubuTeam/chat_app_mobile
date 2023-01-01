part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordEmailChanging extends ForgotPasswordEvent {
  const ForgotPasswordEmailChanging({this.email});

  final String? email;

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordButtonSubmitted extends ForgotPasswordEvent {}
