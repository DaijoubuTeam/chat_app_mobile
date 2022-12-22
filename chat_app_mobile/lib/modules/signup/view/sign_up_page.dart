import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/divider_with_text_center.dart';
import 'package:chat_app_mobile/modules/signup/bloc/sign_up_bloc.dart';
import 'package:chat_app_mobile/modules/signup/widget/sign_up_button.dart';
import 'package:chat_app_mobile/modules/signup/widget/sign_up_confirm_password_input.dart';
import 'package:chat_app_mobile/modules/signup/widget/sign_up_email_input.dart';
import 'package:chat_app_mobile/modules/signup/widget/sign_up_login_button.dart';
import 'package:chat_app_mobile/modules/signup/widget/sign_up_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String namePage = "SignUpPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => SignUpBloc(
            context.read<AuthRepository>(),
          ),
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
                'Create new account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const SignUpEmailInput(),
              const SizedBox(
                height: 4,
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
      ),
    );
  }
}
