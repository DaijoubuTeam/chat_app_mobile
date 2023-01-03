import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:image_picker/image_picker.dart';
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
    on<ModalUploadImageChanged>(_onModalUploadImageChanged);
    on<ModalUploadListImageChanged>(_onModalUploadListImageChanged);
    on<ModalUploadFileSubmitted>(_onModalUploadFileSubmitted);
    on<ModalUploadFileLoaded>(_onModalUploadFileLoaded);
  }

  final auth_repository.AuthRepository _authRepository;
  final message_repository.MessageRepository _chatMessageRepository;

  void _onModalUploadImageChanged(
      ModalUploadImageChanged event, Emitter<ModalUploadFileState> emit) {
    if (state.runtimeType == ModalUploadFileInitial) {
      if (event.type == "image" && event.file != null) {
        List<Map<String, dynamic>>? listMedia =
            (state as ModalUploadFileInitial).media;

        listMedia ??= [];

        listMedia.add({"type": event.type, "file": event.file});

        emit((state as ModalUploadFileInitial).copyWith(media: listMedia));
      }
    }
  }

  void _onModalUploadListImageChanged(
      ModalUploadListImageChanged event, Emitter<ModalUploadFileState> emit) {
    if (state.runtimeType == ModalUploadFileInitial) {
      if (event.type == "image" && event.listFile != null) {
        List<Map<String, dynamic>>? listMedia =
            (state as ModalUploadFileInitial).media;

        listMedia ??= [];

        event.listFile?.forEach((file) {
          listMedia?.add({"type": event.type, "file": file});
        });

        emit((state as ModalUploadFileInitial).copyWith(media: listMedia));
      }
    }
  }

  Future<void> _onModalUploadFileSubmitted(ModalUploadFileSubmitted event,
      Emitter<ModalUploadFileState> emit) async {
    try {
      if (state.runtimeType != ModalUploadFileInitial) return;

      final bearerToken = await _authRepository.bearToken;

      final listMedia = (state as ModalUploadFileInitial).media;

      final List<String> listUrl = [];

      emit(ModalUploadFileSendLoading(chatRoomId: state.chatRoomId));

      if (listMedia != null) {
        for (var item in listMedia) {
          if (item["type"] == "image") {
            final urlDownloadImage = await FireStoreUploadFileService
                .firseStoreService
                .uploadFile(item["file"] as XFile);
            if (urlDownloadImage != null) {
              listUrl.add(urlDownloadImage);
            }
          }
        }

        if (bearerToken != null) {
          for (var url in listUrl) {
            await _chatMessageRepository.sendMessage(
              bearerToken,
              state.chatRoomId,
              url,
              "image",
            );
          }
          emit(ModalUploadFileSendSuccess(chatRoomId: state.chatRoomId));
        }
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
