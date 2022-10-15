import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/src/login/bloc/login_bloc.dart';
import 'package:chat_app_mobile/src/login/widget/login_button.dart';
import 'package:chat_app_mobile/src/login/widget/login_email_input.dart';
import 'package:chat_app_mobile/src/login/widget/login_password_input.dart';
import 'package:chat_app_mobile/src/login/widget/login_signup_button.dart';
import 'package:chat_app_mobile/src/login/widget/login_with_google_button.dart';
import 'package:chat_app_mobile/src/common/widgets/staless/divider_with_text_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => LoginBloc(context.read<AuthRepository>()),
          child: const LoginView(),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
              'Sign-in to your account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const LoginEmailInput(),
            const SizedBox(
              height: 8,
            ),
            const LoginPasswordInput(),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                TextButton(onPressed: null, child: Text('Forgot Password'))
              ],
            ),
            const LoginButton(),
            const SizedBox(
              height: 16,
            ),
            const LoginSignUpButton(),
            const SizedBox(
              height: 8,
            ),
            const DividerWithTextCenter(title: 'Or'),
            const SizedBox(
              height: 8,
            ),
            const LoginWithGoogleButton(),
          ],
        ),
      ),
    );
  }
}
