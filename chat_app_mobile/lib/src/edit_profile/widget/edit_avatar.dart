import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Stack(
          children: [
            CachedNetworkImage(
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              imageUrl: state.avatar,
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
            ),
            Positioned(
              bottom: 1,
              right: 1,
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
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.add_a_photo, color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
