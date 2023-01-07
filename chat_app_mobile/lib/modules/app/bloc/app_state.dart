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
    this.numberNotification = 0,
  });

  final bool isProfileFilled;
  final bool isEmailVerified;
  final int numberNotification;

  AppStateAuthorized copyWith({
    bool? isProfileFilled,
    bool? isEmailVerified,
    int? numberNotification,
  }) {
    return AppStateAuthorized(
      isProfileFilled: isProfileFilled ?? this.isProfileFilled,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      numberNotification: numberNotification ?? this.numberNotification,
    );
  }

  @override
  List<Object> get props =>
      [isProfileFilled, isEmailVerified, numberNotification];
}
