import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpConfirmPasswordInput extends StatelessWidget {
  const SignUpConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_TextField'),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (password) =>
              context.read<SignUpBloc>().add(PasswordChanged(password)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: 'Confirm Password',
            helperText: '',
          ),
        );
      },
    );
  }
}
