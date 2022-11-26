import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:formz/formz.dart';

part 'group_member_event.dart';
part 'group_member_state.dart';

class GroupMemberBloc extends Bloc<GroupMemberEvent, GroupMemberState> {
  GroupMemberBloc(
    chat_room_repo.ChatRoom? chatRoom,
    auth_repo.AuthRepository authRepository,
    chat_room_repo.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(GroupMemberState(
          members: chatRoom?.members.toList(),
          groupName: chatRoom?.chatRoomName,
          chatRoomId: chatRoom!.chatRoomId,
        )) {
    on<GroupMemberDeleteSubmitted>(_onGroupMemberDeleteSubmitted);
  }

  final auth_repo.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupMemberDeleteSubmitted(
      GroupMemberDeleteSubmitted event, Emitter<GroupMemberState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _chatRoomRepository.removeMemberChatRoom(
          bearerToken,
          state.chatRoomId,
          event.idMember,
        );

        if (res) {
          final List<chat_room_repo.User> newListMemberDisplay = state.members!
              .where((member) => member.uid != event.idMember)
              .toList();
          emit(state.copyWith(
              deleteStatus: DeleteStatus.success,
              members: newListMemberDisplay));
        } else {
          emit(state.copyWith(
            deleteStatus: DeleteStatus.failure,
          ));
        }
      }
    } catch (_) {
      emit(state.copyWith(
        deleteStatus: DeleteStatus.failure,
      ));
    }
  }
}
