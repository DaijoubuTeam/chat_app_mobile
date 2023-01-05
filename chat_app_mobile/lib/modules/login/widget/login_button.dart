import 'package:chat_app_mobile/common/widgets/stateless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/hide_keyboard.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  void loginWithEmailAndPassword(
      BuildContext context, Email email, Password password) {
    context.read<LoginBloc>().add(LoginSubmitted(email, password));
    SettingsKeyboard.hideKeyBoard(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return ElevatedButtonCustom(
          onPressed: () => loginWithEmailAndPassword(
            context,
            state.email,
            state.password,
          ),
          text: 'Login',
        );
      },
    );
  }
}
