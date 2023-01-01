part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileEvent extends Equatable {
  const ModalUploadFileEvent();

  @override
  List<Object?> get props => [];
}

class ModalUploadFileLoaded extends ModalUploadFileEvent {}

class ModalUploadFileSubmitted extends ModalUploadFileEvent {
  const ModalUploadFileSubmitted({required this.url, required this.type});
  final List<String> url;
  final String type;

  @override
  List<Object?> get props => [url, type];
}
