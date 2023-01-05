import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hide_keyboard.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    Key? key,
  }) : super(key: key);

  void _handleLoginWithGoogleButton(BuildContext ctx) {
    ctx.read<LoginBloc>().add(LoginWithGoogleSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        _handleLoginWithGoogleButton(context),
        SettingsKeyboard.hideKeyBoard(context)
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.9),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/GoogleLogo@2x.png',
                width: 32,
                height: 33,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Sign in with Google",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(0, 0, 0, 0.54),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
