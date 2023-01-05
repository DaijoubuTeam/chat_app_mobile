import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/dialogs/confirm_dialog.dart';
import '../../app/bloc/app_bloc.dart';

class SettingLogOutButton extends StatelessWidget {
  const SettingLogOutButton({super.key});

  void handleLogOutButton(BuildContext ctx) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Confirm log out",
      "Do you want to log out?",
      [
        DeniedButton(
          handleClick: () {
            // Close the dialog
            Navigator.of(ctx).pop();
          },
        ),
        SizedBox(
          width: 16.sp,
        ),
        AcceptButton(
          handleClick: () {
            ctx.read<AppBloc>().add(AppLogOutRequested());
          },
        )
      ],
    );
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
