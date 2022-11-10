import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart'
    as message_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:formz/formz.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc({
    required String chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
    required auth_repository.AuthRepository authRepository,
    required message_repository.MessageRepository messageRepository,
  })  : _chatMessageRepository = messageRepository,
        _authRepository = authRepository,
        super(ChatDetailState(
          chatRoomId: chatRoomId,
          chatRoomName: chatRoomName ?? '',
          chatRoomAvatar: chatRoomAvatar ??
              'https://img.freepik.com/free-photo/collaborative-process-multicultural-businesspeople-using-laptop-presentation-communication-meeting-brainstorming-ideas-about-project-colleagues-working-plan-success-strategy-modern-office_7861-2510.jpg?w=1800&t=st=1667989860~exp=1667990460~hmac=6b1a65b10f6cfb2489116ee7668aa24e86bcbf4698332bff26f2dc39fde60ba3',
        )) {
    on<ChatDetailPageInited>(_onChatDetailPageInited);
    on<ChatDetailContentChanging>(_onChatDetailContentChanging);
    on<ChatDetailContentSubmited>(_onChatDetailContentSubmited);

    add(ChatDetailPageInited());
  }

  final message_repository.MessageRepository _chatMessageRepository;
  final auth_repository.AuthRepository _authRepository;

  Future<void> _onChatDetailPageInited(
      ChatDetailPageInited event, Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final listMessage = await _chatMessageRepository.getMessages(
          bearerToken,
          _authRepository.currentUser.uid,
          state.chatRoomId,
          0,
          20,
        );

        emit(state.copyWith(listMessage: listMessage));
      }
    } catch (e) {
      log(e.toString(), name: 'chat detail page inited');
    }
  }

  void _onChatDetailContentChanging(
      ChatDetailContentChanging event, Emitter<ChatDetailState> emit) {
    if (event.content == null) {
      return;
    }
    emit(state.copyWith(content: event.content));
  }

  Future<void> _onChatDetailContentSubmited(
      ChatDetailContentSubmited event, Emitter<ChatDetailState> emit) async {
    try {
      if (state.content == null) {
        return;
      }

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final res = await _chatMessageRepository.sendMessage(
            bearerToken, state.chatRoomId, state.content!);

        if (res) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));

          add(ChatDetailPageInited());
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'chatDetailContentSubmited');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
