import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modal_upload_file_event.dart';
part 'modal_upload_file_state.dart';

class ModalUploadFileBloc extends Bloc<ModalUploadFileEvent, ModalUploadFileState> {
  ModalUploadFileBloc() : super(ModalUploadFileInitial()) {
    on<ModalUploadFileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
