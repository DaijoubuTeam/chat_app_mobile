import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;
import 'package:auth_repository/auth_repository.dart' as auth_repo;

part 'group_request_sent_event.dart';
part 'group_request_sent_state.dart';

class GroupRequestSentBloc
    extends Bloc<GroupRequestSentEvent, GroupRequestSentState> {
  GroupRequestSentBloc(
    auth_repo.AuthRepository authRepository,
    chat_room_repo.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(GroupRequestSentInitial()) {
    on<GroupRequestSentInited>(_onGroupRequestSentInited);
    on<GroupRequestSentRefreshed>(_onGroupRequestSentRefreshed);
    on<GroupRequestSentSubmitted>(_onGroupRequestSentSubmitted);
    add(GroupRequestSentInited());
  }

  final auth_repo.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupRequestSentInited(
      GroupRequestSentInited event, Emitter<GroupRequestSentState> emit) async {
    try {
      emit(GroupRequestSentLoading());

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final listGroupRequestSent =
            await _chatRoomRepository.getAllChatRoomSent(bearerToken);

        emit(GroupRequestGetListSentSuccess(
          listGroupRequestSent: listGroupRequestSent,
        ));
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
      emit(GroupRequestSentFailure());
    }
  }

  Future<void> _onGroupRequestSentRefreshed(GroupRequestSentRefreshed event,
      Emitter<GroupRequestSentState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final listGroupRequestSent =
            await _chatRoomRepository.getAllChatRoomSent(bearerToken);

        emit(GroupRequestGetListSentSuccess(
          listGroupRequestSent: listGroupRequestSent,
        ));
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
      emit(GroupRequestSentFailure());
    }
  }

  Future<void> _onGroupRequestSentSubmitted(GroupRequestSentSubmitted event,
      Emitter<GroupRequestSentState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final isUnsentSuccess = await _chatRoomRepository.unsetInivteChatRoom(
            bearerToken, event.chatRoomId, event.friendId);
        if (isUnsentSuccess) {
          FlutterToastCustom.showToast(
              "Successfully revoked invitation", "success");
        } else {
          FlutterToastCustom.showToast("Failed to revoke invitation", "error");
        }
        add(GroupRequestSentRefreshed());
      }
    } catch (err) {
      FlutterToastCustom.showToast("Failed to revoke invitation", "error");
      emit(GroupRequestSentFailure());
    }
  }
}
