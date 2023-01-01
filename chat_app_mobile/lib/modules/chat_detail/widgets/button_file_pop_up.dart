import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_modal_upload_image/view/bottom_modal_upload_image.dart';

class ButtonFilePopUp extends StatelessWidget {
  const ButtonFilePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: ((context) {
                return ModalUploadFilePage(
                  chatRoomId: state.chatRoomId,
                );
              }),
            );
          },
          icon: const Icon(
            Icons.image_outlined,
          ),
        );
      },
    );
  }
}
