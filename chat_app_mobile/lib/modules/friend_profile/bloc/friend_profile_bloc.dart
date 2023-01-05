import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart' as user_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;

part 'friend_profile_event.dart';
part 'friend_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  FriendProfileBloc({
    required String friendId,
    required auth_repository.AuthRepository authRepository,
    required friend_repository.FriendRepository friendRepository,
    required user_repository.UserRepository userRepository,
  })  : _authRepository = authRepository,
        _friendRepository = friendRepository,
        _userRepository = userRepository,
        super(FriendProfileInitial(friendId: friendId)) {
    on<FriendProfilePageInited>(_onFriendProfilePageInited);
    on<FriendProfileButtonSubmitted>(_friendProfileButtonSubmitted);

    add(FriendProfilePageInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;
  final user_repository.UserRepository _userRepository;

  Future<void> _onFriendProfilePageInited(
      FriendProfilePageInited event, Emitter<FriendProfileState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null && state is FriendProfileInitial) {
        final friendId = (state as FriendProfileInitial).friendId;

        final user_repository.User friendInfor =
            await _userRepository.getUserById(bearerToken, friendId);

        final List<friend_repository.User> listRequestFriendSent =
            await _friendRepository.getListRequestsSentFriends(bearerToken);

        bool isRequestSent = listRequestFriendSent
                .indexWhere((requestSent) => requestSent.uid == friendId) !=
            -1;

        emit(FriendProfileGetInforSuccess(
          friendInfor: friendInfor,
          isSentRequest: isRequestSent,
        ));
      }
    } catch (err) {
      emit(FriendProfileGetInforFailure());

      FlutterToastCustom.showToast(err.toString(), "error");
    }
  }

  Future<void> _friendProfileButtonSubmitted(
    FriendProfileButtonSubmitted event,
    Emitter<FriendProfileState> emit,
  ) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null && state is FriendProfileGetInforSuccess) {
        final friendId =
            (state as FriendProfileGetInforSuccess).friendInfor.uid;

        final bool res =
            await _friendRepository.sendFriendRequest(bearerToken, friendId);

        if (res) {
          FlutterToastCustom.showToast("Send request success", "success");
        } else {
          FlutterToastCustom.showToast("Send request fail", "error");
        }
      }
    } catch (err) {
      FlutterToastCustom.showToast("Send request fail", "error");
    }
  }
}
