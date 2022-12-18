part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object?> get props => [];
}

class VerifyEmailInited extends VerifyEmailEvent {}

class VerifyEmailCounted extends VerifyEmailEvent {}

class VerifyEmailChecked extends VerifyEmailEvent {}
