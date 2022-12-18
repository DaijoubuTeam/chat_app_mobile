import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

import '../../../common/widgets/toasts/flutter_toast.dart';

part 'friend_request_sent_event.dart';
part 'friend_request_sent_state.dart';

class FriendRequestSentBloc
    extends Bloc<FriendRequestSentEvent, FriendRequestSentState> {
  FriendRequestSentBloc(this._authRepository, this._friendRepository)
      : super(FriendRequestSentGetListLoading()) {
    on<FriendRequestSentInited>(_onFriendRequestSentInited);
    on<FriendRequestCardSubmitted>(_onFriendRequestCardSubmitted);
    add(FriendRequestSentInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;

  Future<void> _onFriendRequestSentInited(FriendRequestSentInited event,
      Emitter<FriendRequestSentState> emit) async {
    emit(FriendRequestSentGetListLoading());
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res =
            await _friendRepository.getListRequestsSentFriends(bearerToken);
        emit(FriendRequestSentGetListSuccess(listFriendRequestSent: res));
      }
    } catch (e) {
      log(e.toString(), name: "friend request");
      emit(FriendRequestSentGetListFailure());
    }
  }

  Future<void> _onFriendRequestCardSubmitted(FriendRequestCardSubmitted event,
      Emitter<FriendRequestSentState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res =
            await _friendRepository.unsentFriendsRequest(bearerToken, event.id);
        if (res) {
          FlutterToastCustom.showToast(
              "You have successfully revoked your friend request", "success");
        } else {
          FlutterToastCustom.showToast(
              "You have failed to revoke the friend request", "error");
        }
        add(FriendRequestSentInited());
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
    }
  }
}
