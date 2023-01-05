import 'package:chat_app_mobile/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/hide_keyboard.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                SettingsKeyboard.hideKeyBoard(context);
                if (state.email.value == "") {
                  return;
                }
                context
                    .read<ForgotPasswordBloc>()
                    .add(ForgotPasswordButtonSubmitted());
              },
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
                  'Reset Password',
                  style: TextStyle(fontSize: 20),
                ),
              )),
        );
      },
    );
  }
}
