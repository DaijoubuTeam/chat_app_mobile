import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repo;

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({required auth_repo.AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SettingPageInitial()) {
    on<SettingPageInited>(_onSettingPageInited);

    add(const SettingPageInited());
  }

  final auth_repo.AuthRepository _authRepository;

  void _onSettingPageInited(
      SettingPageInited event, Emitter<SettingState> emit) {
    emit(SettingPageInLoading());
    final auth_repo.User user = _authRepository.currentUser;
    emit(SettingPageGetInfoSuccess(user: user));
  }
}
