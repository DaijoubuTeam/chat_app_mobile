import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'group_create_event.dart';
part 'group_create_state.dart';

class GroupCreateBloc extends Bloc<GroupCreateEvent, GroupCreateState> {
  GroupCreateBloc(this._authRepository, this._friendRepository)
      : super(const GroupCreateState()) {
    on<GroupCreateInited>(_onGroupCreateInited);
    on<GroupCreateInputChanged>(_onGroupCreateInputChanged);
    on<GroupCreateMemberChanged>(_onGroupCreateMemberChanged);

    add(GroupCreateInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;

  Future<void> _onGroupCreateInited(
      GroupCreateInited event, Emitter<GroupCreateState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listFriend =
            await _friendRepository.getListUserFriends(bearerToken);
        emit(state.copyWith(
          listFriend: listFriend,
          listFriendDisplay: listFriend,
          memberNewGroup: [],
          status: FormzStatus.submissionSuccess,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onGroupCreateInputChanged(
      GroupCreateInputChanged event, Emitter<GroupCreateState> emit) {
    final listFriendDisplay = state.listFriend
        ?.where((friend) =>
            friend.fullname!.toLowerCase().contains(event.value.toString()))
        .toList();
    emit(state.copyWith(listFriendDisplay: listFriendDisplay));
  }

  void _onGroupCreateMemberChanged(
      GroupCreateMemberChanged event, Emitter<GroupCreateState> emit) {
    if (state.memberNewGroup == null) return;
    final List<friend_repository.User> listNewMember =
        List.from(state.memberNewGroup!);
    if (state.memberNewGroup!.contains(event.user)) {
      listNewMember.remove(event.user);
    } else {
      listNewMember.add(event.user);
    }
    emit(state.copyWith(memberNewGroup: listNewMember));
  }
}
