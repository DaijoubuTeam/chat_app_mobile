import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/modal_upload_file_bloc.dart';

class ChoosePhotoButton extends StatelessWidget {
  const ChoosePhotoButton({super.key});

  void handleTap(BuildContext ctx) async {
    await ImagePicker().pickMultiImage().then((images) => {
          ctx.read<ModalUploadFileBloc>().add(
                ModalUploadListImageChanged(
                  listFile: images,
                  type: "image",
                ),
              ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return MediaButton(
      title: "Choose a photo",
      color: Colors.blue,
      handleTap: () => handleTap(context),
      icon: const Icon(
        Icons.image_outlined,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
