import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:socket_repository/socket_repository.dart' as socket_repo;

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const VerifyEmailState()) {
    on<VerifyEmailInited>(_onVerifyEmailInited);
    on<VerifyEmailChecked>(_onVerifyEmailChecked);
    add(VerifyEmailInited());

    _subcribeNewVerifiedStream();
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late final StreamSubscription<dynamic> _newVerifiedEmailStream;

  Future<void> _onVerifyEmailInited(
      VerifyEmailInited event, Emitter<VerifyEmailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _userRepository.requestVerifyEmail(bearerToken);
        if (res) {
          FlutterToastCustom.showToast("Send verify email success", "success");
        } else {
          FlutterToastCustom.showToast("Send verify email fail", "error");
        }
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
    }
  }

  void _onVerifyEmailChecked(
      VerifyEmailChecked event, Emitter<VerifyEmailState> emit) async {
    emit(state.copyWith(isCheckedEmail: true));
  }

  void _subcribeNewVerifiedStream() {
    _newVerifiedEmailStream = socket_repo
        .SocketAPI.socketApi.verifiedEmailStream.stream
        .listen((newVerifyEmail) {
      print("here");
      add(VerifyEmailChecked());
    });
  }

  @override
  Future<void> close() {
    _newVerifiedEmailStream.cancel();
    return super.close();
  }
}
