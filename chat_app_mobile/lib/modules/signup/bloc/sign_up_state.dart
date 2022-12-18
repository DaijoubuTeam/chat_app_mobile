part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmPassword;
  final FormzStatus status;

  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmPassword,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, status];
}
