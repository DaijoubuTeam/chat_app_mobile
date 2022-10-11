import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpLoginButton extends StatelessWidget {
  const SignUpLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
          onPressed: () => {context.pop()},
          // border radius
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              side: MaterialStateProperty.all(BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.0))),
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
