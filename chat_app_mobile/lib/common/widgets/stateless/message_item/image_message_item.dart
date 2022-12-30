import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // return Container(
    //   constraints:
    //       BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: 1,
    //     vertical: 1,
    //   ),
    //   decoration: BoxDecoration(
    //     color: isMe
    //         ? Theme.of(context).primaryColor
    //         : Colors.grey[800]?.withOpacity(0.1),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: GestureDetector(
    //     onTap: () {
    //       Navigator.push(context, MaterialPageRoute(builder: (_) {
    //         return FullScreenImage(
    //           imageUrl: content!,
    //           tag: "generate_a_unique_tag",
    //         );
    //       }));
    //     },
    //     child: Hero(
    //       tag: "generate_a_unique_tag",
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(20),
    //         child: Image.network(
    //           content!,
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    if (content == null || content == "") {
      return Image.asset("assets/images/image_not_found.jpg");
    }
    return CachedNetworkImage(
      width: 250.w,
      height: 250.h,
      fit: BoxFit.cover,
      imageUrl: content!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          //shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        return Image.asset("assets/images/image_not_found.jpg");
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({
    Key? key,
    required this.imageUrl,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Done",
      ),
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag,
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              imageUrl: imageUrl,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
