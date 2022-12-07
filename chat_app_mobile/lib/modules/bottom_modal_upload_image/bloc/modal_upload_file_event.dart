part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileEvent extends Equatable {
  const ModalUploadFileEvent();

  @override
  List<Object?> get props => [];
}

class ModalUploadFileListMediaChanging extends ModalUploadFileEvent {}

class ModalUploadFileSubmitted extends ModalUploadFileEvent {}
