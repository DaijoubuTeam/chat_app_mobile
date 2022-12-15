import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'login_button.dart';
import 'login_signup_button.dart';

class LoginListButton extends StatelessWidget {
  const LoginListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (prev, current) => prev != current,
        builder: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                ),
              ),
            );
          }
          return Column(
            children: const <Widget>[
              LoginButton(),
              SizedBox(
                height: 16,
              ),
              LoginSignUpButton(),
            ],
          );
        });
  }
}
