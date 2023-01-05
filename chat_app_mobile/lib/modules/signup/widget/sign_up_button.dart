import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hide_keyboard.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  void loginWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
  ) {
    SettingsKeyboard.hideKeyBoard(context);
    context.read<SignUpBloc>().add(SignUpSubmitted(
          email: email,
          password: password,
          confirmedPassword: confirmPassword,
        ));
    //context.pushNamed(VerifyEmailPage.namePage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => loginWithEmailAndPassword(
                  context,
                  state.email.value,
                  state.password.value,
                  state.confirmPassword.value),
              // border radius
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
              )),
        );
      },
    );
  }
}
