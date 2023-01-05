import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/forgot_password/view/view.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:chat_app_mobile/modules/login/widget/login_email_input.dart';
import 'package:chat_app_mobile/modules/login/widget/login_password_input.dart';
import 'package:chat_app_mobile/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widget/login_action_buttons.dart';

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
    return GestureDetector(
      onTap: (() => SettingsKeyboard.hideKeyBoard(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: FormField(
            autovalidateMode: AutovalidateMode.disabled,
            builder: (_) => Column(
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
                Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const LoginEmailInput(),
                const SizedBox(
                  height: 12,
                ),
                const LoginPasswordInput(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          context.pushNamed(ForgotPasswordPage.namePage);
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const LoginActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
