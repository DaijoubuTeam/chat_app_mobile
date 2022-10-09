import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unAuthorized()) {
    on<AppLogOutRequested>(_onAppLogOutRequested);
    on<AppUserChanged>(_onAppUserChanged);
  }

  void _onAppLogOutRequested(AppLogOutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unAuthorized());
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(const AppState.authorized());
  }
}
