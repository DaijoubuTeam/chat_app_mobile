import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/stateless/text_fields/password_outline.dart';

class LoginPasswordInput extends StatefulWidget {
  const LoginPasswordInput({super.key});

  @override
  State<LoginPasswordInput> createState() => _LoginPasswordInputState();
}

class _LoginPasswordInputState extends State<LoginPasswordInput> {
  final TextEditingController _passwordInputController =
      TextEditingController();

  bool _isPasswordVisible = true;

  void _handleOnPressVisibleButton() {
    setState(() => {_isPasswordVisible = !_isPasswordVisible});
  }

  @override
  Widget build(BuildContext context) {
    _passwordInputController.addListener(
      () => context
          .read<LoginBloc>()
          .add(LoginPasswordChanging(_passwordInputController.text)),
    );

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        if (state is LoginSubmitFailure) {
          // to keep remain current value of email text fields when failure
          context
              .read<LoginBloc>()
              .add(LoginPasswordChanging(_passwordInputController.text));
        }
        return PasswordOutline(
          inputController: _passwordInputController,
          isPasswordVisible: _isPasswordVisible,
          handleOnPressVisibleButton: _handleOnPressVisibleButton,
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _passwordInputController.dispose();
    super.dispose();
  }
}
