import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/modal_upload_file_bloc.dart';

class SendMediaButton extends StatelessWidget {
  const SendMediaButton({super.key});

  Future<void> _pickImages(BuildContext ctx) async {
    ctx.read<ModalUploadFileBloc>().add(const ModalUploadFileSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _pickImages(context),
      child: const Icon(Icons.send),
    );
  }
}
