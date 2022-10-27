import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart' as user_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:friend_repository/friend_repository.dart' as friend_repository;

part 'friend_profile_event.dart';
part 'friend_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  FriendProfileBloc({
    required user_repository.User friendSearchInfor,
    required auth_repository.AuthRepository authRepository,
    required friend_repository.FriendRepository friendRepository,
  })  : _friendInfor = friendSearchInfor,
        _authRepository = authRepository,
        _friendRepository = friendRepository,
        super(FriendProfileInitial(friendInfor: friendSearchInfor)) {
    on<FriendProfileButtonSubmitted>(_friendProfileButtonSubmitted);
  }

  final user_repository.User _friendInfor;
  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;

  Future<void> _friendProfileButtonSubmitted(
    FriendProfileButtonSubmitted event,
    Emitter<FriendProfileState> emit,
  ) async {
    final bearerToken = await _authRepository.bearToken;
    if (bearerToken != null) {
      final bool res = await _friendRepository.sendFriendRequest(
          bearerToken, _friendInfor.uid);

      if (res) {
        emit(FriendProfileSendRequestSuccess());
      } else {
        emit(FriendProfileSendRequestFailure());
      }
    }
    try {} catch (err) {
      throw Exception('Exceptuon when handle lick add friends');
    }
  }
}
