import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/hide_keyboard.dart';

class LoginSignUpButton extends StatelessWidget {
  const LoginSignUpButton({super.key});

  void handleSignUpButton(BuildContext ctx) {
    ctx.pushNamed('signUp');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
          onPressed: () => {
                handleSignUpButton(context),
                SettingsKeyboard.hideKeyBoard(context)
              },
          // border radius
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              side: MaterialStateProperty.all(BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.0))),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
