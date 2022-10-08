part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [email, password, confirmPassword];
}
