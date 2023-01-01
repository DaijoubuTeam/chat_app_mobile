import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../edit_profile/view/view.dart';
import '../bloc/setting_bloc.dart';

class SettingAction extends StatelessWidget {
  const SettingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SwitchListTile(
            secondary: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                )
              ],
            ),
            value: true,
            onChanged: ((value) => {}),
            title: Transform.translate(
              offset: const Offset(-16, 0),
              child: const Text(
                'Notifications',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.person_outline,
                  color: Colors.black,
                )
              ],
            ),
            minLeadingWidth: 16,
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: (() async => {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  ),
                  context.read<SettingBloc>().add(SettingPageInited()),
                }),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.password,
                  color: Colors.black,
                )
              ],
            ),
            minLeadingWidth: 16,
            title: const Text(
              'Change password',
              style: TextStyle(fontSize: 18),
            ),
            onTap: (() {
              context.read<SettingBloc>().add(SettingPageChangePassword());
            }),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.person_outline,
                  color: Colors.black,
                )
              ],
            ),
            minLeadingWidth: 16,
            title: const Text(
              'About us',
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
