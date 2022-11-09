import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpEmailInput extends StatefulWidget {
  const SignUpEmailInput({super.key});

  @override
  State<SignUpEmailInput> createState() => _SignUpEmailInputState();
}

class _SignUpEmailInputState extends State<SignUpEmailInput> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.addListener(() {
      context.read<SignUpBloc>().add(EmailChanged(_emailController.text));
    });
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        helperText: '',
      ),
    );
  }
}
