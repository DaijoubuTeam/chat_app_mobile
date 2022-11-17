import 'dart:developer';

import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditAvatar extends StatefulWidget {
  const EditAvatar({super.key});

  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  XFile? imageAvatar;
  UploadTask? uploadTask;
  String? urlDownload;

  Future<void> _pickImage(BuildContext ctx) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final urlDownloadImage =
          await FireStoreUploadFileService.firseStoreService.uploadFile(image);
      if (!mounted) return;
      if (mounted) {
        ctx
            .read<EditProfileBloc>()
            .add(EditProfileAvatarChanged(urlDownloadImage));
      }
      setState(() {
        urlDownload = urlDownloadImage;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    } on FirebaseException catch (e) {
      log('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Stack(
          children: [
            urlDownload == null
                ? CircleAvatarCustom(urlImage: state.avatar)
                : CircleAvatarCustom(urlImage: urlDownload),
            Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 4),
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: IconButton(
                    padding: const EdgeInsets.all(2),
                    iconSize: 24,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                    onPressed: () => _pickImage(context),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
