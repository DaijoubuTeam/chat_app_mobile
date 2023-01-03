import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:image_picker/image_picker.dart';
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
    String? messageId,
    required chat_room_repository.ChatRoomRepository chatRoomRepository,
    required auth_repository.AuthRepository authRepository,
    required message_repository.MessageRepository messageRepository,
  })  : _chatRoomRepository = chatRoomRepository,
        _chatMessageRepository = messageRepository,
        _authRepository = authRepository,
        super(ChatDetailState(chatRoomId: chatRoomId)) {
    on<ChatDetailPageInited>(_onChatDetailPageInited);
    on<ChatDetailPageRefreshed>(_onChatDetailPageRefreshed);
    on<ChatDetailContentChanging>(_onChatDetailContentChanging);
    on<ChatDetailContentSubmitted>(_onChatDetailContentSubmitted);
    on<ChatDetailSpecificSubmitted>(_onChatDetailSpecificSubmitted);
    on<ChatDetailVideoSubmitted>(_onChatDetailVideoSubmitted);
    //load more up
    on<ChatDetailListMessageLoadMore>(_onChatDetailListMessageLoadMore);
    on<ChatDetailListMessageTopLoad>(_onChatDetailListMessageTopLoad);
    on<ChatDetailListMessageDownLoad>(_onChatDetailListMessageDownLoad);
    on<ChatDetailShowOptionChanged>(_onChatDetailShowOptionChanged);

    _messageId = messageId;

    add(ChatDetailPageInited(messageId: messageId));

    _newMessageStreamSubscription = socket_repository
        .SocketAPI.socketApi.newMessageController.stream
        .listen((data) {
      add(ChatDetailPageRefreshed());
    });
  }

  final auth_repository.AuthRepository _authRepository;
  final message_repository.MessageRepository _chatMessageRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;
  late final String? _messageId;

  late final StreamSubscription<socket_repository.NewMessage>
      _newMessageStreamSubscription;

  Future<void> _onChatDetailPageInited(
      ChatDetailPageInited event, Emitter<ChatDetailState> emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final chatRoomInfo = await _chatRoomRepository.getChatRoomById(
          bearerToken,
          state.chatRoomId,
          _authRepository.currentUser.uid,
        );
        List<message_repository.Message> listMessage;

        if (event.messageId != null) {
          listMessage =
              await _getListMessage(bearerToken, 20, 2, event.messageId, null);
        } else {
          listMessage = await _getListMessage(
              bearerToken,
              state.startMessageIndex,
              state.endMessageIndex,
              null,
              chatRoomInfo.latestMessage!.id);
        }

        emit(state.copyWith(
          chatRoomInfo: chatRoomInfo,
          listMessage: listMessage,
          latestMessage: chatRoomInfo.latestMessage,
          status: FormzStatus.pure,
        ));
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      log(e.toString(), name: 'chat detail page inited');
    }
  }

  Future<void> _onChatDetailPageRefreshed(
      ChatDetailPageRefreshed event, Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final listMessage = await _chatMessageRepository.getMessages(
          bearerToken,
          _authRepository.currentUser.uid,
          state.chatRoomInfo!.latestMessage!.id,
          state.startMessageIndex,
          state.endMessageIndex,
        );

        emit(state.copyWith(
          chatRoomInfo: state.chatRoomInfo,
          listMessage: listMessage,
          latestMessage: state.chatRoomInfo!.latestMessage,
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
      List<message_repository.Message> listMessage;
      int newBeforeMessageIndex = state.startMessageIndex + 10;
      int newAfterMessageIndex = state.endMessageIndex + 10;

      if (bearerToken != null) {
        if (_messageId != null) {
          listMessage = await _getListMessage(
            bearerToken,
            newBeforeMessageIndex,
            newAfterMessageIndex,
            _messageId,
            null,
          );
        } else {
          listMessage = await _getListMessage(
            bearerToken,
            newBeforeMessageIndex,
            newAfterMessageIndex,
            null,
            state.chatRoomInfo!.latestMessage!.id,
          );
        }

        emit(state.copyWith(
          listMessage: listMessage,
          startMessageIndex: newBeforeMessageIndex,
          endMessageIndex: newAfterMessageIndex,
          status: FormzStatus.pure,
        ));
      }
    } catch (e) {
      log(e.toString(), name: 'chat detail page inited');
    }
  }

  Future<void> _onChatDetailListMessageTopLoad(
      ChatDetailListMessageTopLoad event, Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      List<message_repository.Message> listMessage;
      int newBeforeMessageIndex = state.startMessageIndex + 10;
      int newAfterMessageIndex = state.endMessageIndex;

      if (bearerToken != null) {
        if (_messageId != null) {
          listMessage = await _getListMessage(
            bearerToken,
            newBeforeMessageIndex,
            newAfterMessageIndex,
            _messageId,
            null,
          );
        } else {
          listMessage = await _getListMessage(
            bearerToken,
            newBeforeMessageIndex,
            newAfterMessageIndex,
            null,
            state.chatRoomInfo!.latestMessage!.id,
          );
        }

        emit(state.copyWith(
          listMessage: listMessage,
          startMessageIndex: newBeforeMessageIndex,
          endMessageIndex: newAfterMessageIndex,
          status: FormzStatus.pure,
        ));
      }
    } catch (e) {
      log(e.toString(), name: 'chat detail page inited');
    }
  }

  Future<void> _onChatDetailListMessageDownLoad(
      ChatDetailListMessageDownLoad event,
      Emitter<ChatDetailState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      List<message_repository.Message> listMessage;
      // int newBeforeMessageIndex = state.startMessageIndex - 10;
      // int newAfterMessageIndex = state.endMessageIndex + 10;

      if (bearerToken != null) {
        if (_messageId != null) {
          listMessage = await _getListMessage(
            bearerToken,
            10,
            10,
            state.listMessage!.first.id,
            null,
          );
        } else {
          listMessage = await _getListMessage(
            bearerToken,
            10,
            10,
            null,
            state.chatRoomInfo!.latestMessage!.id,
          );
        }

        emit(state.copyWith(
          listMessage: listMessage,
          startMessageIndex: 10,
          endMessageIndex: 10,
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

          add(ChatDetailPageRefreshed());
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

          add(ChatDetailPageRefreshed());
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'chatDetailContentSubmitted');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onChatDetailShowOptionChanged(
      ChatDetailShowOptionChanged event, Emitter<ChatDetailState> emit) {
    emit(state.copyWith(
      isShowSticker: event.isShowSticker,
      isShowSend: event.isShowSend,
      isShowEmoji: event.isShowEmoji,
    ));
  }

  Future<List<message_repository.Message>> _getListMessage(
    String bearerToken,
    int before,
    int after,
    String? messageId,
    String? latestMessageId,
  ) async {
    if (messageId != null) {
      return await _chatMessageRepository.getMessages(
        bearerToken,
        _authRepository.currentUser.uid,
        messageId,
        before,
        after,
      );
    }
    return await _chatMessageRepository.getMessages(
      bearerToken,
      _authRepository.currentUser.uid,
      latestMessageId!,
      before,
      after,
    );
  }

  Future<void> _onChatDetailVideoSubmitted(
    ChatDetailVideoSubmitted event,
    Emitter<ChatDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(isUploadLargeFile: true));
      final urlDownloadImage = await FireStoreUploadFileService
          .firseStoreService
          .uploadFile(event.fileVideo);
      if (urlDownloadImage == null) return;

      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final res = await _chatMessageRepository.sendMessage(
          bearerToken,
          state.chatRoomId,
          urlDownloadImage,
          "video",
        );

        if (res) {
          emit(state.copyWith(isUploadLargeFile: false));
          add(ChatDetailPageRefreshed());
        } else {
          FlutterToastCustom.showToast("Send video fail! Try again.", "error");
        }
      }
    } catch (e) {
      log(e.toString(), name: 'chatDetailContentSubmitted');
      FlutterToastCustom.showToast("Send video fail! Try again.", "error");
    }
  }

  @override
  Future<void> close() {
    _newMessageStreamSubscription.cancel();
    return super.close();
  }
}
