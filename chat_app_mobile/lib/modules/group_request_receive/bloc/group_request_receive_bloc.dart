import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:formz/formz.dart';

part 'group_request_receive_event.dart';
part 'group_request_receive_state.dart';

class GroupRequestReceiveBloc
    extends Bloc<GroupRequestReceiveEvent, GroupRequestReceiveState> {
  GroupRequestReceiveBloc(
    auth_repo.AuthRepository authRepository,
    chat_room_repo.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(const GroupRequestReceiveState()) {
    on<GroupRequestReceiveInited>(_onGroupRequestReceiveInited);
    add(GroupRequestReceiveInited());
  }

  final auth_repo.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupRequestReceiveInited(GroupRequestReceiveInited event,
      Emitter<GroupRequestReceiveState> emit) async {
    try {
      emit(const GroupRequestReceiveState(
          status: FormzStatus.submissionInProgress));

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final listGroupRequestReceive =
            await _chatRoomRepository.getAllChatRoomRequest(bearerToken);

        emit(GroupRequestReceiveState(
          listGroupRequestReceived: listGroupRequestReceive,
          status: FormzStatus.submissionSuccess,
        ));
      }
    } catch (err) {
      log(err.toString(), name: "get list request receive");
      emit(const GroupRequestReceiveState(
          status: FormzStatus.submissionFailure));
    }
  }
}
