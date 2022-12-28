import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/forgot_password_button.dart';
import '../widgets/forgot_password_email_input.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const String namePage = "ForgotPasswordPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ForgotPasswordBloc(authRepository: context.read<AuthRepository>()),
      child: const Scaffold(
        appBar: AppBarCustom(
          title: "Forgot Password",
        ),
        body: Center(
          child: ForgotPasswordView(),
        ),
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SingleChildScrollView(
        child: FormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (_) => Column(
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
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "Don't worry! Just type in your email and we will send you a email to reset your password!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const ForgotPasswordEmailInput(),
              const SizedBox(
                height: 20,
              ),
              const ForgotPasswordButton()
            ],
          ),
        ),
      ),
    );
  }
}
