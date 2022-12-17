import 'dart:async';

import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

part 'find_friend_event.dart';
part 'find_friend_state.dart';

class FindFriendBloc extends Bloc<FindFriendEvent, FindFriendState> {
  FindFriendBloc(this._userRepository, this._authRepository)
      : super(FindFriendInitial()) {
    on<FindFriendInputInitialized>(_findFriendInputInitialized);
    on<FindFriendInputSearchChanged>(_findFriendInputSearchChanged);
    on<FindFriendButtonSubmitted>(_findFriendButtonSubmitted);
  }

  final user_repository.UserRepository _userRepository;
  final auth_repository.AuthRepository _authRepository;

  void _findFriendInputInitialized(
      FindFriendInputInitialized event, Emitter<FindFriendState> emit) {
    emit(const FindFriendInputChanging(inputSearch: ''));
  }

  void _findFriendInputSearchChanged(
      FindFriendInputSearchChanged event, Emitter<FindFriendState> emit) {
    emit(
      event.textInput.isNotEmpty
          ? FindFriendInputChanging(inputSearch: event.textInput)
          : FindFriendInitial(),
    );
  }

  Future<void> _findFriendButtonSubmitted(
      FindFriendButtonSubmitted event, Emitter<FindFriendState> emit) async {
    try {
      if (state.runtimeType != FindFriendInputChanging) {
        // not feedback or emit action when state is not FindFriendInputChanging
        return;
      }

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final user_repository.User resUser =
            await _userRepository.searchUserByEmailOrPhone(
          inputSearch: (state as FindFriendInputChanging).inputSearch.trim(),
          bearerToken: bearerToken,
        );

        if (resUser != user_repository.User.empty) {
          emit(FindFriendSuccess(friendInfor: resUser));
        } else {
          emit(FindFriendFailure());
        }
      }
    } catch (err) {
      throw Exception('Exception handle event FindFriendButtonSubmitted');
    }
  }
}
