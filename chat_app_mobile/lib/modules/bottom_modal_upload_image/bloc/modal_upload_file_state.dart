part of 'modal_upload_file_bloc.dart';

abstract class ModalUploadFileState extends Equatable {
  const ModalUploadFileState();

  @override
  List<Object> get props => [];
}

class ModalUploadFileInitial extends ModalUploadFileState {}

class ModalUploadFileUploadSuccess extends ModalUploadFileState {}

class ModalUploadFileSendSuccess extends ModalUploadFileState {}

class ModalUploadFileFailure extends ModalUploadFileState {}
