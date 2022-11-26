import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart' as user_repository;
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

part 'group_add_new_member_event.dart';
part 'group_add_new_member_state.dart';

class GroupAddNewMemberBloc
    extends Bloc<GroupAddNewMemberEvent, GroupAddNewMemberState> {
  GroupAddNewMemberBloc(
    String chatRoomId,
    List<chat_room_repo.User> members,
    this._authRepository,
    this._friendRepository,
    this._chatRoomRepository,
  ) : super(GroupAddNewMemberState(
          chatRoomId: chatRoomId,
          currentMembersInGroup: members,
        )) {
    on<GroupAddNewMemberInputInitialized>(_onGroupAddNewMemberInputInitialized);
    on<GroupAddNewMemberInputSearchChanged>(_onGroupAddNewMemberInputChanging);
    on<GroupAddNewMemberButtonSubmitted>(_onGroupAddNewMemberButtonSubmitted);
    on<GroupOptionsNewMemberChanged>(_onGroupOptionsNewMemberChanged);

    add(GroupAddNewMemberInputInitialized());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupAddNewMemberInputInitialized(
      GroupAddNewMemberInputInitialized event,
      Emitter<GroupAddNewMemberState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listFriend =
            await _friendRepository.getListUserFriends(bearerToken);
        emit(state.copyWith(
          listFriend: listFriend,
          listFriendDisplay: listFriend
              .where((friend) =>
                  state.currentMembersInGroup
                      .indexWhere((member) => member.uid == friend.uid) ==
                  -1)
              .toList(),
          newMemberGroup: [],
          status: FormzStatus.submissionSuccess,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  //search changing
  FutureOr<void> _onGroupAddNewMemberInputChanging(
      GroupAddNewMemberInputSearchChanged event,
      Emitter<GroupAddNewMemberState> emit) {
    final listFriendDisplay = state.listFriend
        ?.where(
          (friend) =>
              (friend.fullname!
                      .toLowerCase()
                      .contains(event.value.toString()) ||
                  friend.email!
                      .toLowerCase()
                      .contains(event.value.toString())) &&
              (state.currentMembersInGroup
                      .indexWhere((member) => member.uid == friend.uid) ==
                  -1),
        )
        .toList();
    emit(state.copyWith(listFriendDisplay: listFriendDisplay));
  }

  void _onGroupOptionsNewMemberChanged(GroupOptionsNewMemberChanged event,
      Emitter<GroupAddNewMemberState> emit) {
    if (state.newMemberGroup == null) return;

    final List<friend_repository.User> listNewMember =
        List.from(state.newMemberGroup!);

    if (state.newMemberGroup!.contains(event.user)) {
      listNewMember.remove(event.user);
    } else {
      listNewMember.add(event.user);
    }

    emit(state.copyWith(newMemberGroup: listNewMember));
  }

  Future<void> _onGroupAddNewMemberButtonSubmitted(
      GroupAddNewMemberButtonSubmitted event,
      Emitter<GroupAddNewMemberState> emit) async {
    try {
      emit(state.copyWith(actionStatus: ActionStatus.loading));

      final List<String>? listIdMembers;
      if (state.newMemberGroup != null) {
        listIdMembers =
            state.newMemberGroup?.map((member) => member.uid).toList();

        if (listIdMembers != null) {
          final bearerToken = await _authRepository.bearToken;

          if (bearerToken != null) {
            for (var idMember in listIdMembers) {
              await _chatRoomRepository.inviteMemberChatRoom(
                  bearerToken, state.chatRoomId, idMember);
            }
            emit(state.copyWith(actionStatus: ActionStatus.success));
            add(GroupAddNewMemberInputInitialized());
          }
        }
      }

      emit(state.copyWith(actionStatus: ActionStatus.failure));
    } catch (_) {
      emit(state.copyWith(actionStatus: ActionStatus.failure));
    }
  }
}
