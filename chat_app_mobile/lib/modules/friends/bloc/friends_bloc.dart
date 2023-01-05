import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';

import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc(this._authRepository, this._friendRepository)
      : super(FriendsInitial()) {
    on<FriendsInited>(_friendsInited);
    on<FriendsDeleted>(_friendsDeleted);

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

        int numberRequestFriend = 0;
        int numberSentFriend = 0;

        await _friendRepository
            .getListRequestFriend(bearerToken)
            .then((listRequest) => {numberRequestFriend = listRequest.length});

        await _friendRepository
            .getListRequestsSentFriends(bearerToken)
            .then((requestSent) => {numberSentFriend = requestSent.length});

        emit(FriendsGetListSuccess(
          listFriend: listFriend,
          numberRequestFriend: numberRequestFriend,
          numberSentRequestFriend: numberSentFriend,
        ));
      }
    } catch (_) {
      emit(FriendsGetListFailure());
    }
  }

  Future<void> _friendsDeleted(
      FriendsDeleted event, Emitter<FriendsState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final isDeleted =
            await _friendRepository.deleteFriend(bearerToken, event.friendId);
        if (isDeleted) {
          FlutterToastCustom.showToast("Delete friend success", "success");
        } else {
          FlutterToastCustom.showToast("Delete friend fail", "error");
        }
        add(const FriendsInited());
      }
    } catch (_) {
      FlutterToastCustom.showToast("Delete friend fail", "error");
    }
  }
}
