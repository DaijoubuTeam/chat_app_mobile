import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(auth_repository.AuthRepository authRepository,
      chat_room_repository.ChatRoomRepository chatRoomRepository)
      : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(ChatInitial()) {
    on<ChatPageInited>(_onChatPageInited);
  }

  final auth_repository.AuthRepository _authRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;

  Future<void> _onChatPageInited(
      ChatPageInited event, Emitter<ChatState> emit) async {
    try {
      emit(ChatGetListRequest());
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final List<chat_room_repository.ChatRoom> listChatRoom =
            await _chatRoomRepository.getChatRoom(bearerToken);
        emit(ChatGetListSuccess(listChatRoom: listChatRoom));
      }
    } catch (_) {
      emit(ChatGetListFailure());
    }
  }
}
