part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileState extends Equatable {
  const ModalUploadFileState({required this.chatRoomId});

  final String chatRoomId;

  @override
  List<Object?> get props => [chatRoomId];
}

class ModalUploadFileInitial extends ModalUploadFileState {
  const ModalUploadFileInitial({
    required super.chatRoomId,
    this.media,
    this.listUrl,
  });

  final List<Map<String, dynamic>>? media;
  final List<String>? listUrl;

  ModalUploadFileInitial copyWith({
    List<Map<String, dynamic>>? media,
    List<String>? listUrl,
  }) {
    return ModalUploadFileInitial(
        chatRoomId: chatRoomId,
        media: media ?? this.media,
        listUrl: listUrl ?? this.listUrl);
  }

  @override
  List<Object?> get props => [media, listUrl];
}

class ModalUploadFileSendLoading extends ModalUploadFileState {
  const ModalUploadFileSendLoading({required super.chatRoomId});
}

class ModalUploadFileSendSuccess extends ModalUploadFileState {
  const ModalUploadFileSendSuccess({required super.chatRoomId});
}

class ModalUploadFileSendFailure extends ModalUploadFileState {
  const ModalUploadFileSendFailure({required super.chatRoomId});
}
