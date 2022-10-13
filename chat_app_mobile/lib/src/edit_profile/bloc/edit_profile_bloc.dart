import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(UserRepository userRepository, AuthRepository authRepository)
      : _userRepository = userRepository,
        _authRepository = authRepository,
        super(EditProfileInitial()) {
    on<EditProfilePageInited>(_onEditProfilePageInited);
    add(EditProfilePageInited());
  }

  final UserRepository _userRepository;

  final AuthRepository _authRepository;

  Future<void> _onEditProfilePageInited(
      EditProfilePageInited event, Emitter<EditProfileState> emit) async {
    try {
      final bearToken = await _authRepository.bearToken;
      if (bearToken != null) {
        final user = await _userRepository.getSelfProfile(bearToken);
        emit(state.copyWith(
            email: user.email,
            fullname: user.fullname,
            phone: user.phone,
            about: user.about,
            avatar: user.avatar));
      }
    } catch (err) {}
  }
}
