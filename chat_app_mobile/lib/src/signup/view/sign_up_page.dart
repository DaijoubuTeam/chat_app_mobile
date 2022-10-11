import 'package:chat_app_mobile/src/signup/bloc/sign_up_bloc.dart';
import 'package:chat_app_mobile/src/signup/widget/sign_up_button.dart';
import 'package:chat_app_mobile/src/signup/widget/sign_up_confirm_password_input.dart';
import 'package:chat_app_mobile/src/signup/widget/sign_up_email_input.dart';
import 'package:chat_app_mobile/src/signup/widget/sign_up_login_button.dart';
import 'package:chat_app_mobile/src/signup/widget/sign_up_password_input.dart';
import 'package:chat_app_mobile/src/widgets/staless/divider_with_text_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.chevron_left,
      //       color: Colors.black,
      //       size: 36,
      //     ),
      //     onPressed: () {
      //       context.pop();
      //     },
      //   ),
      // ),
      body: Center(
        child: BlocProvider(
          create: (_) => SignUpBloc(),
          child: const SignUpView(),
        ),
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Sign up an account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const SignUpEmailInput(),
            const SizedBox(
              height: 8,
            ),
            const SignUpPasswordInput(),
            const SizedBox(
              height: 8,
            ),
            const SignUpConfirmPasswordInput(),
            const SizedBox(
              height: 8,
            ),
            const SignUpButton(),
            const SizedBox(
              height: 16,
            ),
            const DividerWithTextCenter(title: 'Or'),
            const SizedBox(
              height: 16,
            ),
            const SignUpLoginButton()
          ],
        ),
      ),
    );
  }
}
