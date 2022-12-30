import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';

class SettingLogOutButton extends StatelessWidget {
  const SettingLogOutButton({super.key});

  void handleLogOutButton(BuildContext ctx) {
    ctx.read<AppBloc>().add(AppLogOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        iconColor: Colors.red[400],
        textColor: Colors.red[400],
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Icon(Icons.login_outlined)],
        ),
        minLeadingWidth: 16,
        title: const Text(
          'Log out',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () => handleLogOutButton(context),
      ),
    );
  }
}
