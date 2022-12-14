import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
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
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _friendRepository.getListRequestFriend(bearerToken);
        emit(FriendsRequestGetListSuccess(listFriendRequest: res));
      }
    } catch (e) {
      log(e.toString(), name: "friend request");
      emit(FriendsRequestGetListFailure());
    }
  }

  Future<void> _friendRequestCardAction(
      FriendRequestCardAction event, Emitter<FriendsRequestState> emit) async {
    final bearerToken = await _authRepository.bearToken;
    if (bearerToken != null) {
      final res = await _friendRepository.actionWithFriend(
          bearerToken, event.id, event.action);
      if (res) {
        if (event.action == "accept") {
          FlutterToastCustom.showToast(
              "You have accepted the friend request", "success");
        }
        if (event.action == "denied") {
          FlutterToastCustom.showToast(
              "You have denied the friend request", "success");
        }
      } else {
        FlutterToastCustom.showToast("Something wrongs! Try again", "error");
      }
      add(const FriendRequestPageInited());
    }
  }
}
