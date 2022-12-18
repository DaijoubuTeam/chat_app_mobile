part of 'verify_email_bloc.dart';

class VerifyEmailState extends Equatable {
  const VerifyEmailState({
    this.disableResent = true,
    this.isCheckedEmail = false,
  });

  final bool disableResent;
  final bool isCheckedEmail;

  VerifyEmailState copyWith({
    bool? disableResent,
    bool? isCheckedEmail,
  }) {
    return VerifyEmailState(
      disableResent: disableResent ?? this.disableResent,
      isCheckedEmail: isCheckedEmail ?? this.isCheckedEmail,
    );
  }

  @override
  List<Object> get props => [disableResent, isCheckedEmail];
}
