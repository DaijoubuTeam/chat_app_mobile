part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppStateLoading extends AppState {}

class AppStateUnAuthorized extends AppState {}

class AppStateAuthorized extends AppState {
  const AppStateAuthorized({
    this.isProfileFilled = false,
    this.isEmailVerified = false,
  });

  final bool isProfileFilled;
  final bool isEmailVerified;

  AppStateAuthorized copyWith({
    bool? isProfileFilled,
    bool? isEmailVerified,
  }) {
    return AppStateAuthorized(
      isProfileFilled: isProfileFilled ?? this.isProfileFilled,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object> get props => [isProfileFilled, isEmailVerified];
}
