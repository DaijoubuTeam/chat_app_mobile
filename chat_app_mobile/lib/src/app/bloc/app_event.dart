part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogOutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {}
