import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    Key? key,
  }) : super(key: key);

  void handleLoginWithGoogleButton(BuildContext ctx) {
    ctx.read<LoginBloc>().add(const LoginWithGoogleSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => handleLoginWithGoogleButton(context),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, elevation: 5.0),
        icon: const Icon(
          Icons.g_mobiledata,
          size: 48,
          color: Colors.black,
        ),
        label: const Text(
          'Sign in with Google',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
