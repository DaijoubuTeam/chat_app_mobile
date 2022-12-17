import 'dart:developer';

import 'package:chat_app_mobile/modules/group_edit/bloc/group_edit_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/stateless/avatars/circle_avatar_network.dart';

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
        ctx
            .read<GroupEditBloc>()
            .add(GroupEditAvatarChanged(urlImage: urlDownloadImage));
      }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    } on FirebaseException catch (e) {
      log('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
      builder: (context, state) {
        if (state is GroupEditGetInforSuccess) {
          return Container(
            height: 200,
            width: 200,
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
                    child: Stack(
                      children: [
                        CircleAvatarCustom(
                          urlImage: state.groupAvatar,
                          widthImage: 200,
                          heightImage: 200,
                        ),
                        Positioned(
                          bottom: 4.w,
                          right: 4.h,
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
                              height: 48,
                              width: 48,
                              child: IconButton(
                                padding: const EdgeInsets.all(2),
                                iconSize: 40,
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
                    ),
                  ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
