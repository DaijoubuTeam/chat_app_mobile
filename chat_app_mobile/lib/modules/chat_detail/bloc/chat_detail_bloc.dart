import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart'
    as message_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:socket_repository/socket_repository.dart' as socket_repository;
import 'package:formz/formz.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc({
    required String chatRoomId,
    required chat_room_repository.ChatRoomRepository chatRoomRepository,
    required auth_repository.AuthRepository authRepository,
    required message_repository.MessageRepository messageRepository,
  })  : _chatRoomRepository = chatRoomRepository,
        _chatMessageRepository = messageRepository,
        _authRepository = authRepository,
        super(ChatDetailState(chatRoomId: chatRoomId)) {
    on<ChatDetailPageInited>(_onChatDetailPageInited);
    on<ChatDetailContentChanging>(_onChatDetailContentChanging);
    on<ChatDetailContentSubmitted>(_onChatDetailContentSubmitted);
    on<ChatDetailSpecificSubmitted>(_onChatDetailSpecificSubmitted);
    on<ChatDetailListMessageLoadMore>(_onChatDetailListMessageLoadMore);

    add(ChatDetailPageInited());

    _newMessageStreamSubscription = socket_repository
        .SocketAPI.socketApi.newMessageController.stream
        .listen((data) {
      add(ChatDetailPageInited());
    });
  }

  final auth_repository.AuthRepository _authRepository;
  final message_repository.MessageRepository _chatMessageRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;

  late final StreamSubscription<socket_repository.NewMessage>
      _newMessageStreamSubscription;

  Future<void> _onChatDetailPageInited(
      ChatDetailPageInited event, Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final chatRoomInfo = await _chatRoomRepository.getChatRoomById(
            bearerToken, state.chatRoomId);
        final listMessage = await _chatMessageRepository.getMessages(
          bearerToken,
          _authRepository.currentUser.uid,
          chatRoomInfo.latestMessage!.id,
          state.startMessageIndex,
          state.endMessageIndex,
        );

        emit(state.copyWith(
          chatRoomInfo: chatRoomInfo,
          listMessage: listMessage,
          displayListMessage: listMessage,
          latestMessage: chatRoomInfo.latestMessage,
          status: FormzStatus.pure,
        ));
      }
    } catch (e) {
      log(e.toString(), name: 'chat detail page inited');
    }
  }

  Future<void> _onChatDetailListMessageLoadMore(
      ChatDetailListMessageLoadMore event,
      Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final newBeforeMessageIndex = state.startMessageIndex + 10;
        final newAfterMessageIndex = state.endMessageIndex;
        //final displayListMessage = state.displayListMessage!;
        final listMessage = await _chatMessageRepository.getMessages(
          bearerToken,
          _authRepository.currentUser.uid,
          state.chatRoomInfo!.latestMessage!.id,
          newBeforeMessageIndex,
          newAfterMessageIndex,
        );

        emit(state.copyWith(
          listMessage: listMessage,
          displayListMessage: listMessage,
          startMessageIndex: newBeforeMessageIndex,
          endMessageIndex: newAfterMessageIndex,
          status: FormzStatus.pure,
        ));
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

  Future<void> _onChatDetailContentSubmitted(
      ChatDetailContentSubmitted event, Emitter<ChatDetailState> emit) async {
    try {
      if (state.content == null) {
        return;
      }

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final res = await _chatMessageRepository.sendMessage(
          bearerToken,
          state.chatRoomId,
          state.content!,
          state.type,
        );

        if (res) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));

          add(ChatDetailPageInited());
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'chatDetailContentSubmitted');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> _onChatDetailSpecificSubmitted(
    ChatDetailSpecificSubmitted event,
    Emitter<ChatDetailState> emit,
  ) async {
    try {
      if (event.content == null || event.type == null) {
        return;
      }

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final res = await _chatMessageRepository.sendMessage(
          bearerToken,
          state.chatRoomId,
          event.content!,
          event.type!,
        );

        if (res) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));

          add(ChatDetailPageInited());
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'chatDetailContentSubmitted');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  @override
  Future<void> close() {
    _newMessageStreamSubscription.cancel();
    return super.close();
  }
}
