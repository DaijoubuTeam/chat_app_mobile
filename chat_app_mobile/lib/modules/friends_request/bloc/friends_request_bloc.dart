import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'friends_request_event.dart';
part 'friends_request_state.dart';

class FriendsRequestBloc
    extends Bloc<FriendsRequestEvent, FriendsRequestState> {
  FriendsRequestBloc(this._authRepository, this._friendRepository)
      : super(FriendsRequestInitial()) {
    on<FriendRequestPageInited>(_friendRequestPageInited);
    on<FriendRequestCardAction>(_friendRequestCardAction);

    add(const FriendRequestPageInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;

  Future<void> _friendRequestPageInited(
      FriendRequestPageInited event, Emitter<FriendsRequestState> emit) async {
    emit(FriendsRequestGetListInProgress());
    final bearerToken = await _authRepository.bearToken;
    if (bearerToken != null) {
      final res = await _friendRepository.getListRequestFriend(bearerToken);
      if (res.isNotEmpty) {
        emit(FriendsRequestGetListSuccess(listFriendRequest: res));
      } else {
        emit(FriendsRequestGetListFailure());
      }
    }
  }

  Future<void> _friendRequestCardAction(
      FriendRequestCardAction event, Emitter<FriendsRequestState> emit) async {
    final bearerToken = await _authRepository.bearToken;
    if (bearerToken != null) {
      final res = await _friendRepository.actionWithFriend(
          bearerToken, event.id, event.action);
      if (res) {
        emit(FriendsRequestCardActionSuccess());
      } else {
        emit(FriendsRequestCardActionFailure());
      }
      add(const FriendRequestPageInited());
    }
  }
}
