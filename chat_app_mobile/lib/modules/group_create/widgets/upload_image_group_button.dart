import 'dart:developer';

import 'package:chat_app_mobile/modules/group_create/bloc/group_create_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/stateless/avatars/circle_avatar_network.dart';

class UploadImageGroupButton extends StatefulWidget {
  const UploadImageGroupButton({Key? key}) : super(key: key);

  @override
  State<UploadImageGroupButton> createState() => _UploadImageGroupButtonState();
}

class _UploadImageGroupButtonState extends State<UploadImageGroupButton> {
  XFile? imageAvatar;
  UploadTask? uploadTask;
  String? urlDownload;

  Future<void> _pickImage(BuildContext ctx) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final urlDownloadImage =
          await FireStoreUploadFileService.firseStoreService.uploadFile(image);
      if (mounted) {
        ctx
            .read<GroupCreateBloc>()
            .add(GroupCreateAvatarImageChanged(urlImage: urlDownloadImage));
      }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    } on FirebaseException catch (e) {
      log('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCreateBloc, GroupCreateState>(
      builder: (context, state) {
        return Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: state.groupAvatar == null
              ? IconButton(
                  padding: const EdgeInsets.all(2),
                  iconSize: 48,
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                  ),
                  onPressed: () => _pickImage(context),
                )
              : GestureDetector(
                  child: CircleAvatarCustom(
                    urlImage: state.groupAvatar,
                  ),
                ),
        );
      },
    );
  }
}
