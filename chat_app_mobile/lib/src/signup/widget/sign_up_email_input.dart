import 'package:chat_app_mobile/src/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpEmailInput extends StatelessWidget {
  const SignUpEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: ((previos, current) => previos.email != current.email),
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) =>
                context.read<SignUpBloc>().add(EmailChanged(email)),
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              helperText: '',
            ),
          );
        });
  }
}
