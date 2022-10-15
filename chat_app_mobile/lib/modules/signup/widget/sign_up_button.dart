import 'package:chat_app_mobile/modules/signup/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  void loginWithEmailAndPassword(BuildContext context) {
    //context.read<SignUpBloc>().add(const SignUpSubmitted());
    context.pushNamed(VerifyEmailPage.namePage);
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
              'Sign Up',
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
