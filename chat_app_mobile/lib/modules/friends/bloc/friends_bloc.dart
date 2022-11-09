import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc(this._authRepository, this._friendRepository)
      : super(FriendsInitial()) {
    on<FriendsInited>(_friendsInited);

    add(const FriendsInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;

  Future<void> _friendsInited(
      FriendsInited event, Emitter<FriendsState> emit) async {
    emit(FriendsGetListInProgress());
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listFriend =
            await _friendRepository.getListUserFriends(bearerToken);
        emit(FriendsGetListSuccess(listFriend: listFriend));
      }
    } catch (_) {
      emit(FriendsGetListFailure());
    }
  }
}
