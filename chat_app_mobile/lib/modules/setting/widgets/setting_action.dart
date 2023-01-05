import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../edit_profile/view/view.dart';
import '../bloc/setting_bloc.dart';
import 'card_change_password.dart';
import 'card_devices.dart';

class SettingAction extends StatelessWidget {
  const SettingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 8.h),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(8.0),
        //   ),
        //   child: SwitchListTile(
        //     secondary: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const <Widget>[
        //         Icon(
        //           Icons.notifications_outlined,
        //           color: Colors.black,
        //         )
        //       ],
        //     ),
        //     value: true,
        //     onChanged: ((value) => {}),
        //     title: Transform.translate(
        //       offset: const Offset(-16, 0),
        //       child: const Text(
        //         'Notifications',
        //         style: TextStyle(fontSize: 18),
        //       ),
        //     ),
        //   ),
        // ),
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
                    // PageRouteBuilder(
                    //   pageBuilder: (_, __, ___) => const EditProfilePage(),
                    //   transitionDuration: const Duration(milliseconds: 250),
                    //   transitionsBuilder: (_, animation, __, child) =>
                    //       SlideTransition(
                    //     position: animation.drive(
                    //       Tween(
                    //         begin: const Offset(1.5, 0),
                    //         end: Offset.zero,
                    //       ).chain(
                    //         CurveTween(curve: Curves.ease),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  ),
                  context.read<SettingBloc>().add(SettingPageInited()),
                }),
          ),
        ),
        SizedBox(height: 4.h),
        const CardDevices(),
        SizedBox(height: 4.h),
        const CardChangePassword(),
        SizedBox(height: 4.h),
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
        SizedBox(height: 8.h),
      ],
    );
  }
}
