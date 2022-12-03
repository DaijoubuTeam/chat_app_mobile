import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
    this.urlImage,
    this.widthImage = 120,
    this.heightImage = 120,
  });

  final String? urlImage;
  final double? widthImage;
  final double? heightImage;

  @override
  Widget build(BuildContext context) {
    if (urlImage == null) {
      return const CircleAvatar(
        backgroundImage: AssetImage('assets/images/empty_avatar.png'),
        maxRadius: 24,
      );
    }
    return CachedNetworkImage(
      width: widthImage,
      height: heightImage,
      fit: BoxFit.cover,
      imageUrl: urlImage!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
    );
  }
}
