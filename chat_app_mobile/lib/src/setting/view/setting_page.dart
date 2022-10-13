import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/src/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/src/edit_profile/view/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  void handleLogOutButton(BuildContext ctx) {
    ctx.read<AppBloc>().add(AppLogOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthRepository>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              CachedNetworkImage(
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                imageUrl: user.avatar!,
                imageBuilder: (context, imageProvider) => Container(
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
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                user.email ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(
                height: 15.0,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: ListView(
                  children: [
                    SwitchListTile(
                      value: true,
                      onChanged: ((value) => {}),
                      title: const Text(
                        'Stop notification',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: (() {
                        context.pushNamed(EditProfilePage.namePage);
                      }),
                    ),
                    const ListTile(
                      title: Text(
                        'About us',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      iconColor: Colors.red[400],
                      textColor: Colors.red[400],
                      title: const Text(
                        'Log out',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () => handleLogOutButton(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
