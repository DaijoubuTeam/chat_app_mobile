import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class EditProfilePage extends StatelessWidget {
  static String namePage = 'EditProfilePage';

  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final userRepository = context.read<UserRepository>();
    return BlocProvider(
      create: (_) => EditProfileBloc(userRepository, authRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          // SizedBox(
                          //   width: 120,
                          //   height: 120,
                          //   child: AspectRatio(
                          //     aspectRatio: 1 / 1,
                          //     child: ClipOval(
                          //       child: FadeInImage(
                          //         placeholder: const AssetImage(
                          //             'assets/images/Logo.png'),
                          //         image: NetworkImage(state.avatar),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          CachedNetworkImage(
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              imageUrl: state.avatar,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                log(error.toString(), name: 'url error');
                                return const Icon(Icons.error);
                              }),
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
                                child: Icon(Icons.add_a_photo,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          helperText: '',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Fullname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          helperText: '',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          helperText: '',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'About',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Align(
                            alignment: Alignment.topCenter,
                            widthFactor: 1.0,
                            heightFactor: 3.3,
                            child: Icon(Icons.info_outline_rounded),
                          ),
                          helperText: '',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => {},
                            // border radius
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Let\'s start',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
