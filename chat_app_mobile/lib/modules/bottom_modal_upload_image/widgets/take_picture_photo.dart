import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/modal_upload_file_bloc.dart';

class TakePictureButton extends StatelessWidget {
  const TakePictureButton({super.key});

  void handleTap(BuildContext ctx) async {
    final res = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 1,
    );

    ctx.read<ModalUploadFileBloc>().add(
          ModalUploadImageChanged(
            file: res,
            type: "image",
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MediaButton(
      title: "Take a photo",
      color: Colors.pink,
      handleTap: () => handleTap(context),
      icon: const Icon(
        Icons.camera_outlined,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
