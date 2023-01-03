import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/bloc/modal_upload_file_bloc.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/choose_photo_button.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/list_attachment.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/send_media_button.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/take_picture_photo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_upload_file/firestore_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';

class ModalUploadFilePage extends StatelessWidget {
  const ModalUploadFilePage({super.key, required this.chatRoomId});

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ModalUploadFileBloc(
        chatRoomId: chatRoomId,
        authRepository: context.read<AuthRepository>(),
        messageRepository: context.read<MessageRepository>(),
      ),
      child: const BottomModalFile(),
    );
  }
}

class BottomModalFile extends StatefulWidget {
  const BottomModalFile({super.key});

  @override
  State<BottomModalFile> createState() => _BottomModalFileState();
}

class _BottomModalFileState extends State<BottomModalFile> {
  // List<String> listUrl = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalUploadFileBloc, ModalUploadFileState>(
      //listenWhen: (previous, current) => previous != current,
      // listener: (context, state) {
      //   if (state is ModalUploadFileSendFailure ||
      //       state is ModalUploadFileSendSuccess) {
      //     Navigator.of(context).pop();
      //   }
      // },
      builder: (context, state) {
        return BlocBuilder<ModalUploadFileBloc, ModalUploadFileState>(
          builder: (context, state) {
            if (state is ModalUploadFileSendLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ModalUploadFileInitial) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //send media button
                      if (state.media != null && state.media!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[SendMediaButton()],
                        ),

                      // area show image
                      const SizedBox(
                        height: 10,
                      ),
                      if (state.media != null && state.media!.isNotEmpty)
                        const ListAttachment(),
                      const SizedBox(
                        height: 14,
                      ),

                      Wrap(
                        children: const <Widget>[
                          ChoosePhotoButton(),
                          TakePictureButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ModalUploadFileSendLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container();
          },
        );
      },
    );
  }

  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //       stream: FireStoreUploadFileService
  //           .firseStoreService.uploadTask?.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final data = snapshot.data!;
  //           double progress = data.bytesTransferred / data.totalBytes;

  //           return SizedBox(
  //             height: 50,
  //             child: Stack(
  //               fit: StackFit.expand,
  //               children: [
  //                 LinearProgressIndicator(
  //                   value: progress,
  //                   backgroundColor: Colors.grey,
  //                   color: Colors.green,
  //                 ),
  //                 Center(
  //                   child: Text(
  //                     '${(100 * progress).roundToDouble()}%',
  //                     style: const TextStyle(color: Colors.white),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         } else {
  //           return Container(
  //             color: Colors.black,
  //             height: 20,
  //           );
  //         }
  //       },
  //     );
}
