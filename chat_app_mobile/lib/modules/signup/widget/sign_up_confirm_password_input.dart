import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../common/widgets/stateless/text_fields/password_outline.dart';

class SignUpConfirmPasswordInput extends StatefulWidget {
  const SignUpConfirmPasswordInput({super.key});

  @override
  State<SignUpConfirmPasswordInput> createState() =>
      _SignUpConfirmPasswordInputState();
}

class _SignUpConfirmPasswordInputState
    extends State<SignUpConfirmPasswordInput> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = true;

  void _handleOnPressVisibleButton() {
    setState(() => {_isPasswordVisible = !_isPasswordVisible});
  }

  @override
  Widget build(BuildContext context) {
    _confirmPasswordController.addListener(() {
      context
          .read<SignUpBloc>()
          .add(ConfirmPasswordChanged(_confirmPasswordController.text));
    });

    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          context
              .read<SignUpBloc>()
              .add(PasswordChanged(_confirmPasswordController.text));
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: PasswordOutline(
            labelText: "Confirm password",
            inputController: _confirmPasswordController,
            isPasswordVisible: _isPasswordVisible,
            handleOnPressVisibleButton: _handleOnPressVisibleButton,
            errorText: state.confirmPassword.invalid
                ? 'not match your password'
                : null,
          ),
        );
      },
    );
  }
}
