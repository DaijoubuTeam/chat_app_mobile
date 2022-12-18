part of 'app_bloc.dart';

// enum AppStatus { loading, unAuthorized, authorized }

// class AppState extends Equatable {
//   const AppState._({required this.status});

//   const AppState.loading() : this._(status: AppStatus.loading);

//   const AppState.unAuthorized() : this._(status: AppStatus.unAuthorized);

//   const AppState.authorized() : this._(status: AppStatus.authorized);

//   final AppStatus status;

//   @override
//   List<Object> get props => [status];
// }

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

  @override
  List<Object> get props => [isProfileFilled, isEmailVerified];
}
