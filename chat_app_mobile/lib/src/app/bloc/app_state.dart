part of 'app_bloc.dart';

enum AppStatus { loading, unAuthorized, authorized }

class AppState extends Equatable {
  const AppState._({required this.status});

  const AppState.loading() : this._(status: AppStatus.loading);

  const AppState.unAuthorized() : this._(status: AppStatus.unAuthorized);

  const AppState.authorized() : this._(status: AppStatus.authorized);

  final AppStatus status;

  @override
  List<Object> get props => [status];
}
