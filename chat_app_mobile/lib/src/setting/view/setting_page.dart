import 'package:auth_repository/auth_repository.dart';
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
              CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: Image.network(
                    user.avatar!,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    ListTile(
                      title: const Text(
                        'About us',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          context.read<AppBloc>().add(AppLogOutRequested()),
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
