import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common/widgets/stateless/text_fields/outline_input_border_custom.dart';

class ForgotPasswordEmailInput extends StatefulWidget {
  const ForgotPasswordEmailInput({super.key});

  @override
  State<ForgotPasswordEmailInput> createState() =>
      _ForgotPasswordEmailInputState();
}

class _ForgotPasswordEmailInputState extends State<ForgotPasswordEmailInput> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.addListener(() {
      //context.read<SignUpBloc>().add(EmailChanged(_emailController.text));
    });
    return OutlineInputBorderCustom(
      inputController: _emailController,
      inputType: TextInputType.emailAddress,
      labelText: 'Email',
      hintText: 'abc@gmail.com',
      icon: const Icon(Icons.email),
      //errorText: state.email.invalid ? "Invalid email" : null,
    );
  }
}
