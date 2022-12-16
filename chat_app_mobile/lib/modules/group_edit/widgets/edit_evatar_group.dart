import 'dart:developer';

import 'package:chat_app_mobile/modules/group_edit/bloc/group_edit_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditAvatarGroup extends StatefulWidget {
  const EditAvatarGroup({super.key});

  @override
  State<EditAvatarGroup> createState() => _EditAvatarGroupState();
}

class _EditAvatarGroupState extends State<EditAvatarGroup> {
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
        // ctx
        //     .read<GroupEditBloc>()
        //     .add(GroupCreateAvatarImageChanged(urlImage: urlDownloadImage));
      }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    } on FirebaseException catch (e) {
      log('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
