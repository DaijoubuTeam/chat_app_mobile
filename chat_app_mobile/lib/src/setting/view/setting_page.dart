import 'package:chat_app_mobile/src/app/bloc/app_bloc.dart';
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
                radius: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Nguyễn Đình Nhật Quang',
                style: TextStyle(fontSize: 18),
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
                    const ListTile(
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.chevron_right),
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
