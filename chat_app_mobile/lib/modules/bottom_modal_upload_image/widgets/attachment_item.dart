import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentItem extends StatelessWidget {
  const AttachmentItem({
    super.key,
    this.attachment,
  });

  final Map<String, dynamic>? attachment;

  void _handleRemoveMedia() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 210.h,
      color: Colors.white,
      margin: const EdgeInsets.only(right: 10),
      child: (attachment != null)
          ? Stack(
              children: [
                // if (attachment["type"] == "video")
                //   VideoPlayer(VideoPlayerController.file(attachment["file"])
                //     ..initialize().then((_) => {})),
                if (attachment!["type"] == "image")
                  Image.file(
                    width: 140.w,
                    height: 210.h,
                    File((attachment!["file"] as XFile).path),
                    fit: BoxFit.cover,
                  ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.cancel,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
