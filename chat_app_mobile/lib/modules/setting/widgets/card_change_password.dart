import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/dialogs/confirm_dialog.dart';
import '../bloc/setting_bloc.dart';

class CardChangePassword extends StatelessWidget {
  const CardChangePassword({
    Key? key,
  }) : super(key: key);

  void _handleClickButtonChangePassword(BuildContext ctx) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Reset password",
      " Do you want to reset your password?",
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
            ctx.read<SettingBloc>().add(SettingPageChangePassword());
            Navigator.of(ctx).pop();
          },
        ),
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
        onTap: () => _handleClickButtonChangePassword(context),
      ),
    );
  }
}
