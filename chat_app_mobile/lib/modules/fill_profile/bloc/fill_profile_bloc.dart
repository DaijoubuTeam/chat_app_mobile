import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:user_repository/src/models/models.dart' as user_model;

part 'fill_profile_event.dart';
part 'fill_profile_state.dart';

class FillProfileBloc extends Bloc<FillProfileEvent, FillProfileState> {
  FillProfileBloc(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const FillProfileState()) {
    on<FillProfilePageInited>(_onFillProfilePageInited);
    on<FillProfileEmailChanged>(_onFillProfileEmailChanged);
    on<FillProfileFullNameChanged>(_onFillProfileFullNameChanged);
    on<FillProfilePhoneChanged>(_onFillProfilePhoneChanged);
    on<FillProfileAboutChanged>(_onFillProfileAboutChanged);
    on<FillProfileAvatarChanged>(_onFillProfileAvatarChanged);
    on<FillProfileFormSubmited>(_onFillProfileFormSubmited);
    add(FillProfilePageInited());
  }

  final UserRepository _userRepository;

  final AuthRepository _authRepository;

  Future<void> _onFillProfilePageInited(
      FillProfilePageInited event, Emitter<FillProfileState> emit) async {
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
      FlutterToastCustom.showToast(err.toString(), "error");
      //log(err.toString(), name: 'edit profile page inited error');
    }
  }

  void _onFillProfileEmailChanged(
      FillProfileEmailChanged event, Emitter<FillProfileState> emit) {
    emit(event.email.isNotEmpty
        ? state.copyWith(email: event.email)
        : state.copyWith(email: ''));
  }

  void _onFillProfileFullNameChanged(
      FillProfileFullNameChanged event, Emitter<FillProfileState> emit) {
    emit(event.fullname.isNotEmpty
        ? state.copyWith(fullname: event.fullname)
        : state.copyWith(fullname: ''));
  }

  void _onFillProfilePhoneChanged(
      FillProfilePhoneChanged event, Emitter<FillProfileState> emit) {
    emit(event.phone.isNotEmpty
        ? state.copyWith(phone: event.phone)
        : state.copyWith(phone: ''));
  }

  void _onFillProfileAboutChanged(
      FillProfileAboutChanged event, Emitter<FillProfileState> emit) {
    emit(event.about.isNotEmpty
        ? state.copyWith(about: event.about)
        : state.copyWith(about: ''));
  }

  Future<void> _onFillProfileFormSubmited(
      FillProfileFormSubmited event, Emitter<FillProfileState> emit) async {
    try {
      if (state.fullname == null || state.fullname == "") {
        FlutterToastCustom.showToast("Full name cannot be empty", "warning");
        return;
      }
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final user = user_model.User(
          uid: state.uid!,
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

  void _onFillProfileAvatarChanged(
      FillProfileAvatarChanged event, Emitter<FillProfileState> emit) {
    emit(state.copyWith(avatar: event.urlImage));
  }
}
