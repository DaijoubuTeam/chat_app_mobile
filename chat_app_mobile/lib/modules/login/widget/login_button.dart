import 'package:chat_app_mobile/common/widgets/stateless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  void loginWithEmailAndPassword(
      BuildContext context, String? email, String? password) {
    context.read<LoginBloc>().add(LoginSubmitted(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.runtimeType == LoginStateInitial) {
          final stateValue = state as LoginStateInitial;
          return ElevatedButtonCustom(
            onPressed: () => loginWithEmailAndPassword(
                context, stateValue.email, stateValue.password),
            text: 'Login',
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
