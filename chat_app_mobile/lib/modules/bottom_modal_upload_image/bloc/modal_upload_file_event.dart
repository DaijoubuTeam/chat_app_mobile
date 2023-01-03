part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileEvent extends Equatable {
  const ModalUploadFileEvent();

  @override
  List<Object?> get props => [];
}

class ModalUploadFileLoaded extends ModalUploadFileEvent {}

class ModalUploadImageChanged extends ModalUploadFileEvent {
  const ModalUploadImageChanged({
    required this.file,
    required this.type,
  });
  final XFile? file;
  final String type;

  @override
  List<Object?> get props => [file, type];
}

class ModalUploadListImageChanged extends ModalUploadFileEvent {
  const ModalUploadListImageChanged({
    required this.listFile,
    required this.type,
  });
  final List<XFile>? listFile;
  final String type;

  @override
  List<Object?> get props => [listFile, type];
}

class ModalUploadFileSubmitted extends ModalUploadFileEvent {
  const ModalUploadFileSubmitted();

  @override
  List<Object?> get props => [];
}
