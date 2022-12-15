import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/edit_profile/view/view.dart';
import 'package:chat_app_mobile/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/stateless/avatars/circle_avatar_network.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Setting Page'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const SettingView(),
      ),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  void handleLogOutButton(BuildContext ctx) {
    ctx.read<AppBloc>().add(AppLogOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingPageGetInfoSuccess) {
          return Center(
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
                  CircleAvatarCustom(
                    urlImage: state.user.avatar,
                    widthImage: 160,
                    heightImage: 160,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    state.user.email ?? '',
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
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SettingPageGetInfoFailure) {
          return const Center(
            child: Text("Somethings wrong!"),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
