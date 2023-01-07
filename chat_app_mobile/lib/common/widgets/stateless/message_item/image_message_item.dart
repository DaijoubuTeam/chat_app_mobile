import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../full_screen_image/full_screen_image.dart';

class ImageMessageItem extends IMessageItem {
  const ImageMessageItem({
    super.key,
    this.content,
    this.isMe = false,
  });

  final String? content;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    if (content == null || content == "") {
      return Image.asset("assets/images/image_not_found.jpg");
    }
    return CachedNetworkImage(
      width: 250.w,
      height: 250.h,
      fit: BoxFit.cover,
      imageUrl: content!,
      imageBuilder: (context, imageProvider) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullScreenImage(imageUrl: content!)));
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
      placeholder: (context, url) => const Skeleton.rectangular(),
      errorWidget: (context, url, error) {
        return Image.asset("assets/images/image_not_found.jpg");
      },
    );
  }
}
