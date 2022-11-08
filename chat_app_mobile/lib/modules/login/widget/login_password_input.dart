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
    _passwordInputController.addListener(() => context
        .read<LoginBloc>()
        .add(LoginPasswordChanging(_passwordInputController.text)));

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) => {
        if (state.runtimeType == LoginSubmitFailure ||
            state.runtimeType == LoginStateInitial)
          {
            // to keep remain current value of email text fields when failure
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanging(_passwordInputController.text)),
          }
      },
      // child: TextFormField(
      //   controller: _passwordInputController,
      //   decoration: InputDecoration(
      //     hintText: 'Your Password ...',
      //     labelText: 'Password',
      //     prefixIcon: const Icon(Icons.lock),
      //     suffixIcon: IconButton(
      //       icon: isPasswordVisible
      //           ? const Icon(Icons.visibility_off)
      //           : const Icon(Icons.visibility_off),
      //       onPressed: () =>
      //           setState(() => {isPasswordVisible = !isPasswordVisible}),
      //     ),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      //   obscureText: isPasswordVisible,
      // ),
      child: PasswordOutline(
        inputController: _passwordInputController,
        isPasswordVisible: _isPasswordVisible,
        handleOnPressVisibleButton: _handleOnPressVisibleButton,
      ),
    );
  }

  @override
  void dispose() {
    _passwordInputController.dispose();
    super.dispose();
  }
}
