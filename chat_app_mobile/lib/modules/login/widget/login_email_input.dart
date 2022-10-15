import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: ((previos, current) => previos.email != current.email),
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) =>
              context.read<LoginBloc>().add(EmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            helperText: '',
          ),
        );
      },
    );
  }
}
