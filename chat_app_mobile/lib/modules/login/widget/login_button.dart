import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  void loginWithEmailAndPassword(BuildContext context) {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => loginWithEmailAndPassword(context),
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
              'Login',
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
