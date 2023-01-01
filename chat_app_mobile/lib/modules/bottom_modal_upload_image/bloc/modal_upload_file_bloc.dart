import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:message_repository/message_repository.dart'
    as message_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;

part 'modal_upload_file_event.dart';
part 'modal_upload_file_state.dart';

class ModalUploadFileBloc
    extends Bloc<ModalUploadFileEvent, ModalUploadFileState> {
  ModalUploadFileBloc({
    required String chatRoomId,
    required auth_repository.AuthRepository authRepository,
    required message_repository.MessageRepository messageRepository,
  })  : _authRepository = authRepository,
        _chatMessageRepository = messageRepository,
        super(ModalUploadFileInitial(chatRoomId: chatRoomId)) {
    on<ModalUploadFileSubmitted>(_onModalUploadFileSubmitted);
    on<ModalUploadFileLoaded>(_onModalUploadFileLoaded);
  }

  final auth_repository.AuthRepository _authRepository;
  final message_repository.MessageRepository _chatMessageRepository;

  Future<void> _onModalUploadFileSubmitted(ModalUploadFileSubmitted event,
      Emitter<ModalUploadFileState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        for (var url in event.url) {
          await _chatMessageRepository.sendMessage(
            bearerToken,
            state.chatRoomId,
            url,
            event.type,
          );
        }
        emit(ModalUploadFileSendSuccess(chatRoomId: state.chatRoomId));
      }
    } catch (err) {
      FlutterToastCustom.showToast(err.toString(), "error");
    }
  }

  void _onModalUploadFileLoaded(
      ModalUploadFileLoaded event, Emitter<ModalUploadFileState> emit) {
    emit(ModalUploadFileSendLoading(chatRoomId: state.chatRoomId));
  }
}
