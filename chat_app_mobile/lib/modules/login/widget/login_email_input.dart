import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginEmailInput extends StatefulWidget {
  const LoginEmailInput({super.key});

  @override
  State<LoginEmailInput> createState() => _LoginEmailInputState();
}

class _LoginEmailInputState extends State<LoginEmailInput> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.addListener(
      () => context
          .read<LoginBloc>()
          .add(LoginEmailChanging(_emailController.text)),
    );
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          context
              .read<LoginBloc>()
              .add(LoginEmailChanging(_emailController.text));
        }
        return OutlineInputBorderCustom(
          inputController: _emailController,
          inputType: TextInputType.emailAddress,
          labelText: 'Email',
          hintText: 'abc@gmail.com',
          icon: const Icon(
            Icons.email,
            // color: state.email.invalid
            //     ? Theme.of(context).errorColor
            //     : Theme.of(context).gre,
          ),
          errorText: state.email.invalid ? "invalid email" : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
