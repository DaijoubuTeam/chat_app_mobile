import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bottom_modal_upload_image/view/bottom_modal_upload_image.dart';
import 'pop_up_menu_button.dart';

class ButtonFilePopUp extends StatelessWidget {
  const ButtonFilePopUp({super.key});

  void _selectMenuItem(
      String value, BuildContext ctx, String chatRoomId) async {
    switch (value) {
      case "image":
        {
          showModalBottomSheet(
            context: ctx,
            builder: ((context) {
              return ModalUploadFilePage(
                chatRoomId: chatRoomId,
              );
            }),
          );
          return;
        }
      case "video":
        {
          _handlePickVideo(ctx);
          return;
        }
    }
  }

  void _handlePickVideo(BuildContext ctx) async {
    await ImagePicker().pickVideo(source: ImageSource.gallery).then((video) {
      if (video != null) {
        ctx
            .read<ChatDetailBloc>()
            .add(ChatDetailVideoSubmitted(fileVideo: video));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return PopupMenuButton(
          offset: const Offset(0, -120),
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
          onSelected: (value) =>
              _selectMenuItem(value, context, state.chatRoomId),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "image",
              child: PopUpMenuItemButton(
                  label: "Image",
                  icon: Icons.image_outlined,
                  chatRoomId: state.chatRoomId),
            ),
            PopupMenuItem(
              value: "video",
              child: PopUpMenuItemButton(
                  label: "Video",
                  icon: Icons.video_camera_back_outlined,
                  chatRoomId: state.chatRoomId),
            )
          ],
        );
      },
    );
  }
}
