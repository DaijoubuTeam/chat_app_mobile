import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
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

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return OutlineInputBorderCustom(
          inputController: _emailController,
          inputType: TextInputType.emailAddress,
          labelText: 'Email (*)',
          hintText: 'abc@gmail.com',
          icon: const Icon(Icons.email),
          errorText: state.email.invalid ? "Invalid email" : null,
        );
      },
    );
  }
}
