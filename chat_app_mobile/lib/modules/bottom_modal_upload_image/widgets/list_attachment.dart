import 'package:chat_app_mobile/modules/bottom_modal_upload_image/bloc/modal_upload_file_bloc.dart';
import 'package:chat_app_mobile/modules/bottom_modal_upload_image/widgets/attachment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListAttachment extends StatelessWidget {
  const ListAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalUploadFileBloc, ModalUploadFileState>(
      builder: (context, state) {
        final listMedia = (state as ModalUploadFileInitial).media;

        print(listMedia?.length);
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 210.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[350],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return AttachmentItem(
                attachment: listMedia![index],
              );
            }),
            itemCount: listMedia?.length,
          ),
        );
      },
    );
  }
}
