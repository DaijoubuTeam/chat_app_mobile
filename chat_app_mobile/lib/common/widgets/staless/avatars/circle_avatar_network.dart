import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({super.key, required this.urlImage});
  final String? urlImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      imageUrl: urlImage ?? '',
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
        log(error.toString(), name: 'url error');
        return const Icon(Icons.error);
      },
    );
  }
}
