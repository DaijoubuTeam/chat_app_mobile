import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart'
    as message_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:socket_repository/socket_repository.dart' as socket_repository;
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
            chatRoomName: chatRoomName,
            chatRoomAvatar: chatRoomAvatar)) {
    on<ChatDetailPageInited>(_onChatDetailPageInited);
    on<ChatDetailContentChanging>(_onChatDetailContentChanging);
    on<ChatDetailContentSubmitted>(_onChatDetailContentSubmitted);
    on<ChatDetailSpecificSubmitted>(_onChatDetailSpecificSubmitted);

    add(ChatDetailPageInited());

    _newMessageStreamSubscription = socket_repository
        .SocketAPI.SocketApi.newMessageController.stream
        .listen((data) {
      add(ChatDetailPageInited());
    });
  }

  final message_repository.MessageRepository _chatMessageRepository;
  final auth_repository.AuthRepository _authRepository;

  late final StreamSubscription<socket_repository.NewMessage>
      _newMessageStreamSubscription;

  Future<void> _onChatDetailPageInited(
      ChatDetailPageInited event, Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      //log(state.chatRoomId, name: "chatroomid");
      print(state.chatRoomId);

      if (bearerToken != null) {
        final listMessage = await _chatMessageRepository.getMessages(
          bearerToken,
          _authRepository.currentUser.uid,
          state.chatRoomId,
          0,
          20,
        );

        emit(
            state.copyWith(listMessage: listMessage, status: FormzStatus.pure));
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
