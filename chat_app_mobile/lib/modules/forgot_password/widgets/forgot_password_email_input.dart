import 'package:chat_app_mobile/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordEmailChanging(email: _emailController.text));
    });
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
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
