import 'package:chat_app_mobile/common/widgets/staless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  void loginWithEmailAndPassword(BuildContext context) {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonCustom(
      onPressed: () => loginWithEmailAndPassword(context),
      text: 'Login',
    );
  }
}
