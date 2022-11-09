import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpConfirmPasswordInput extends StatefulWidget {
  const SignUpConfirmPasswordInput({super.key});

  @override
  State<SignUpConfirmPasswordInput> createState() =>
      _SignUpConfirmPasswordInputState();
}

class _SignUpConfirmPasswordInputState
    extends State<SignUpConfirmPasswordInput> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _confirmPasswordController.addListener(() {
      context
          .read<SignUpBloc>()
          .add(ConfirmPasswordChanged(_confirmPasswordController.text));
    });

    return TextField(
      key: const Key('loginForm_passwordInput_TextField'),
      controller: _confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: 'Confirm Password',
        helperText: '',
      ),
    );
  }
}
