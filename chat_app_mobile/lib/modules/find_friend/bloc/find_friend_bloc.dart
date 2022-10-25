import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'find_friend_event.dart';
part 'find_friend_state.dart';

class FindFriendBloc extends Bloc<FindFriendEvent, FindFriendState> {
  FindFriendBloc(this._userRepository, this._authRepository)
      : super(const FindFriendState()) {
    on<FindFriendInputSearchChanged>(_findFriendInputSearchChanged);
    on<FindFriendButtonSubmitted>(_findFriendButtonSubmitted);
  }

  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  void _findFriendInputSearchChanged(event, Emitter<FindFriendState> emit) {
    emit(event.textInput.isNotEmpty
        ? state.copyWith(inputSearch: event.textInput)
        : state.copyWith());
  }

  Future<void> _findFriendButtonSubmitted(
      FindFriendButtonSubmitted event, Emitter<FindFriendState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        await _userRepository.searchUserByEmailOrPhone(
            inputSearch: state.inputSearch, bearerToken: bearerToken);
      }
    } catch (err) {}
  }
}
