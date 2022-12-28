part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileState extends Equatable {
  const ModalUploadFileState({required this.chatRoomId});

  final String chatRoomId;

  @override
  List<Object> get props => [chatRoomId];
}

class ModalUploadFileInitial extends ModalUploadFileState {
  const ModalUploadFileInitial({required super.chatRoomId});
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
