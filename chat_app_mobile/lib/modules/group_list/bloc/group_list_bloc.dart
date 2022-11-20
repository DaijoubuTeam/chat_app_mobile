import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:formz/formz.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  GroupListBloc(
    auth_repository.AuthRepository authRepository,
    chat_room_repository.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(const GroupListState()) {
    on<GroupListInited>(_onGroupListInited);
    on<GroupListGroupDeleted>(_onGroupListGroupDeleted);
    add(GroupListInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupListInited(
      GroupListInited event, Emitter<GroupListState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final List<chat_room_repository.ChatRoom> listChatRoom =
            await _chatRoomRepository.getChatRoom(bearerToken);

        final List<chat_room_repository.ChatRoom> listGroupChatJoined =
            listChatRoom.where((chatRoom) => chatRoom.type == 'group').toList();

        emit(
          state.copyWith(
            listChatRoom: listGroupChatJoined,
            status: FormzStatus.submissionCanceled,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> _onGroupListGroupDeleted(
      GroupListGroupDeleted event, Emitter<GroupListState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _chatRoomRepository.deleteGroupChatRoom(
            bearerToken, event.idChatRoom);

        if (res) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
