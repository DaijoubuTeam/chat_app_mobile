import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/src/models/models.dart' as user_model;

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(UserRepository userRepository, AuthRepository authRepository)
      : _userRepository = userRepository,
        _authRepository = authRepository,
        super(const EditProfileState()) {
    on<EditProfilePageInited>(_onEditProfilePageInited);
    on<EditProfileEmailChanged>(_onEditProfileEmailChanged);
    on<EditProfileFullNameChanged>(_onEditProfileFullNameChanged);
    on<EditProfilePhoneChanged>(_onEditProfilePhoneChanged);
    on<EditProfileAboutChanged>(_onEditProfileAboutChanged);
    on<EditProfileAvatarChanged>(_onEditProfileAvatarChanged);
    on<EditProfileFormSubmited>(_onEditProfileFormSubmited);
    add(EditProfilePageInited());
  }

  final UserRepository _userRepository;

  final AuthRepository _authRepository;

  Future<void> _onEditProfilePageInited(
      EditProfilePageInited event, Emitter<EditProfileState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final user = await _userRepository.getSelfProfile(bearerToken);
        emit(state.copyWith(
            uid: user.uid,
            email: user.email,
            fullname: user.fullname,
            phone: user.phone,
            about: user.about,
            avatar: user.avatar));
      }
    } catch (err) {
      log(err.toString(), name: 'edit profile page inited error');
    }
  }

  void _onEditProfileEmailChanged(
      EditProfileEmailChanged event, Emitter<EditProfileState> emit) {
    emit(event.email.isNotEmpty
        ? state.copyWith(email: event.email)
        : state.copyWith(email: ''));
  }

  void _onEditProfileFullNameChanged(
      EditProfileFullNameChanged event, Emitter<EditProfileState> emit) {
    emit(event.fullname.isNotEmpty
        ? state.copyWith(fullname: event.fullname)
        : state.copyWith(fullname: ''));
  }

  void _onEditProfilePhoneChanged(
      EditProfilePhoneChanged event, Emitter<EditProfileState> emit) {
    emit(event.phone.isNotEmpty
        ? state.copyWith(phone: event.phone)
        : state.copyWith(phone: ''));
  }

  void _onEditProfileAboutChanged(
      EditProfileAboutChanged event, Emitter<EditProfileState> emit) {
    emit(event.about.isNotEmpty
        ? state.copyWith(about: event.about)
        : state.copyWith(about: ''));
  }

  Future<void> _onEditProfileFormSubmited(
      EditProfileFormSubmited event, Emitter<EditProfileState> emit) async {
    try {
      if (state.fullname == null || state.fullname == "") {
        FlutterToastCustom.showToast("Full name cannot be empty", "warning");
        return;
      }
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final user = user_model.User(
          uid: state.uid,
          email: state.email,
          fullname: state.fullname,
          phone: state.phone,
          about: state.about,
          avatar: state.avatar,
        );
        final updatedUser =
            await _userRepository.updateSelfProfile(user, bearerToken);
        if (updatedUser != user_model.User.empty) {
          emit(
            state.copyWith(
                uid: updatedUser.uid,
                email: updatedUser.email,
                fullname: updatedUser.fullname,
                phone: updatedUser.phone,
                about: updatedUser.about,
                avatar: updatedUser.avatar,
                status: FormzStatus.submissionSuccess),
          );
          FlutterToastCustom.showToast("Edit profile success", "success");
        } else {
          FlutterToastCustom.showToast("Edit profile fail", "error");
        }
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
    }
  }

  void _onEditProfileAvatarChanged(
      EditProfileAvatarChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(avatar: event.urlImage));
  }
}
