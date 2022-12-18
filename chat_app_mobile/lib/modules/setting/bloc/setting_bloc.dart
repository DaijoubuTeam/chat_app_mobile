import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:user_repository/user_repository.dart' as user_repo;

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({
    required auth_repo.AuthRepository authRepository,
    required user_repo.UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(SettingPageInitial()) {
    on<SettingPageInited>(_onSettingPageInited);
    on<SettingPageChangePassword>(_onSettingPageChangePassword);

    add(SettingPageInited());
  }

  final auth_repo.AuthRepository _authRepository;
  final user_repo.UserRepository _userRepository;

  Future<void> _onSettingPageInited(
      SettingPageInited event, Emitter<SettingState> emit) async {
    emit(SettingPageInLoading());
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final user_repo.User userInfor =
            await _userRepository.getSelfProfile(bearerToken);
        emit(SettingPageGetInfoSuccess(user: userInfor));
      }
    } catch (err) {
      FlutterToastCustom.showToast(
          "Get information of user fail! Try again", "error");
      emit(SettingPageGetInfoFailure());
    }
  }

  Future<void> _onSettingPageChangePassword(
      SettingPageChangePassword event, Emitter<SettingState> emit) async {
    if (state is SettingPageGetInfoSuccess) {
      try {
        final email = (state as SettingPageGetInfoSuccess).user.email;
        if (email != null) {
          final res = await _authRepository.forgotPassword(email);
          if (res) {
            FlutterToastCustom.showToast(
                "Send email success! Please check email.", "success");
          } else {
            FlutterToastCustom.showToast(
                "Send email fail! Try again.", "error");
          }
        } else {
          FlutterToastCustom.showToast("Email empty", "warning");
        }
      } catch (err) {
        FlutterToastCustom.showToast(
            "Get information of user fail! Try again", "error");
        emit(SettingPageGetInfoFailure());
      }
    }
  }
}
