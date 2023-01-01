import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:formz/formz.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repository;

part 'chat_room_detail_event.dart';
part 'chat_room_detail_state.dart';

class ChatRoomDetailBloc
    extends Bloc<ChatRoomDetailEvent, ChatRoomDetailState> {
  ChatRoomDetailBloc({
    required String chatRoomId,
    String? chatRoomAvatar,
    String? chatRoomName,
    required auth_repository.AuthRepository authRepository,
    required chat_room_repository.ChatRoomRepository chatRoomRepository,
    required friend_repository.FriendRepository friendRepository,
  })  : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        _friendRepository = friendRepository,
        super(ChatRoomDetailInitial(chatRoomId: chatRoomId)) {
    on<ChatRoomDetailInited>(_onChatRoomDetailInited);
    on<ChatRoomDetailFriendDeleted>(_onChatRoomDetailFriendDeleted);

    add(ChatRoomDetailInited());
  }

  final chat_room_repository.ChatRoomRepository _chatRoomRepository;
  final friend_repository.FriendRepository _friendRepository;
  final auth_repository.AuthRepository _authRepository;

  Future<void> _onChatRoomDetailInited(
      ChatRoomDetailInited event, Emitter<ChatRoomDetailState> emit) async {
    try {
      emit(ChatRoomDetailGetDataInProgress(chatRoomId: state.chatRoomId));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final chatRoomInfor = await _chatRoomRepository.getChatRoomById(
          bearerToken,
          state.chatRoomId,
          _authRepository.currentUser.uid,
        );
        emit(ChatRoomDetailGetDataSuccess(
          chatRoomId: state.chatRoomId,
          chatRoomInformation: chatRoomInfor,
        ));
      } else {
        emit(ChatRoomDetailGetDataFailure(
          chatRoomId: state.chatRoomId,
        ));
      }
    } catch (e) {
      log(e.toString(), name: "ChatRoomDetailInited");
      emit(ChatRoomDetailGetDataFailure(
        chatRoomId: state.chatRoomId,
      ));
    }
  }

  Future<void> _onChatRoomDetailFriendDeleted(ChatRoomDetailFriendDeleted event,
      Emitter<ChatRoomDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _friendRepository.deleteFriend(
          bearerToken,
          event.friendId,
        );
        if (state is ChatRoomDetailGetDataSuccess) {
          emit((state as ChatRoomDetailGetDataSuccess)
              .copyWith(status: FormzStatus.submissionSuccess));
        }
        if (res) {
          FlutterToastCustom.showToast("Delete friend success", "success");
        } else {
          FlutterToastCustom.showToast("Delete friend fail", "error");
        }
      }
    } catch (e) {
      FlutterToastCustom.showToast("Delete friend fail", "error");
    }
  }
}
