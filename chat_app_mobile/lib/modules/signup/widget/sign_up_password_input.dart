import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../common/widgets/stateless/text_fields/password_outline.dart';

class SignUpPasswordInput extends StatefulWidget {
  const SignUpPasswordInput({super.key});

  @override
  State<SignUpPasswordInput> createState() => _SignUpPasswordInputState();
}

class _SignUpPasswordInputState extends State<SignUpPasswordInput> {
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
          .read<SignUpBloc>()
          .add((PasswordChanged(_passwordInputController.text))),
    );
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          context
              .read<SignUpBloc>()
              .add(PasswordChanged(_passwordInputController.text));
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: PasswordOutline(
            inputController: _passwordInputController,
            isPasswordVisible: _isPasswordVisible,
            handleOnPressVisibleButton: _handleOnPressVisibleButton,
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}
