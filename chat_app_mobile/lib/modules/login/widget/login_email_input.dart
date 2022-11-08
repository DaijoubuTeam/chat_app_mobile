import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) => {
        if (state.runtimeType == LoginSubmitFailure ||
            state.runtimeType == LoginStateInitial)
          {
            // to keep remain current value of email text fields when failure
            context
                .read<LoginBloc>()
                .add(LoginEmailChanging(_emailController.text)),
          }
      },
      child: OutlineInputBorderCustom(
        inputController: _emailController,
        inputType: TextInputType.emailAddress,
        labelText: 'Email',
        hintText: 'abc@gmail.com',
        icon: const Icon(Icons.email),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
