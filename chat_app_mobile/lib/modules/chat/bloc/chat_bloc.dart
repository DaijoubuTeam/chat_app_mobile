import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:socket_repository/socket_repository.dart' as socket_repository;
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    auth_repository.AuthRepository authRepository,
    chat_room_repository.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(ChatInitial()) {
    on<ChatPageInited>(_onChatPageInited);
    on<ChatPageRefreshed>(_onChatPageRefreshed);

    add(ChatPageInited());

    _newMessageStreamSubscription = socket_repository
        .SocketAPI.socketApi.newMessageController.stream
        .listen((data) {
      log("data");
      add(ChatPageRefreshed());
    });
    _newEventChatRoomStreamSubscription = socket_repository
        .SocketAPI.socketApi.newEventChatRoomController.stream
        .listen((_) {
      add(ChatPageRefreshed());
    });
  }

  final auth_repository.AuthRepository _authRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;

  late final StreamSubscription<socket_repository.NewMessage>
      _newMessageStreamSubscription;
  late final StreamSubscription _newEventChatRoomStreamSubscription;

  Future<void> _onChatPageInited(
      ChatPageInited event, Emitter<ChatState> emit) async {
    try {
      emit(ChatGetListRequest());
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final List<chat_room_repository.ChatRoom> listChatRoom =
            await _chatRoomRepository.getChatRoom(
                bearerToken, _authRepository.currentUser.uid);

        listChatRoom.sort((room1, room2) {
          return room2.latestMessage!.createdAt!
              .compareTo(room1.latestMessage!.createdAt!);
        });
        emit(ChatGetListSuccess(listChatRoom: listChatRoom));
      }
    } catch (_) {
      emit(ChatGetListFailure());
    }
  }

  Future<void> _onChatPageRefreshed(
      ChatPageRefreshed event, Emitter<ChatState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final List<chat_room_repository.ChatRoom> listChatRoom =
            await _chatRoomRepository.getChatRoom(
                bearerToken, _authRepository.currentUser.uid);

        listChatRoom.sort((room1, room2) {
          return room2.latestMessage!.createdAt!
              .compareTo(room1.latestMessage!.createdAt!);
        });
        emit(ChatGetListSuccess(listChatRoom: listChatRoom));
      }
    } catch (_) {
      emit(ChatGetListFailure());
    }
  }

  @override
  Future<void> close() {
    _newMessageStreamSubscription.cancel();
    _newEventChatRoomStreamSubscription.cancel();
    return super.close();
  }
}
