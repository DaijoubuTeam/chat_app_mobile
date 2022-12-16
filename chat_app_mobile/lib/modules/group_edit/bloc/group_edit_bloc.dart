import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

part 'group_edit_event.dart';
part 'group_edit_state.dart';

class GroupEditBloc extends Bloc<GroupEditEvent, GroupEditState> {
  GroupEditBloc({
    required String groupId,
    required auth_repository.AuthRepository authRepository,
    required chat_room_repo.ChatRoomRepository chatRoomRepository,
  })  : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        _groupId = groupId,
        super(GroupEditInitial(groupId: groupId)) {
    on<GroupEditInited>(_onGroupInited);
  }

  final String _groupId;
  final auth_repository.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupInited(
      GroupEditInited event, Emitter<GroupEditState> emit) async {
    try {
      emit(GroupEditInitial(groupId: _groupId));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final chat_room_repo.ChatRoom groupInfor =
            await _chatRoomRepository.getChatRoomById(
          bearerToken,
          _groupId,
          _authRepository.currentUser.uid,
        );
        emit(GroupEditGetInforSuccess(
          groupId: _groupId,
          groupName: groupInfor.chatRoomName,
          groupAvatar: groupInfor.chatRoomAvatar,
        ));
      }
    } catch (_) {
      emit(GroupEditGetInforFailure(groupId: _groupId));
    }
  }
}
