import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/divider_with_text_center.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:chat_app_mobile/modules/login/widget/login_email_input.dart';
import 'package:chat_app_mobile/modules/login/widget/login_list_button.dart';
import 'package:chat_app_mobile/modules/login/widget/login_password_input.dart';
import 'package:chat_app_mobile/modules/login/widget/login_with_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

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
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, current) =>
          prev != current && current.status == FormzStatus.submissionFailure,
      listener: (context, state) => {
        if (state.status == FormzStatus.submissionFailure)
          {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text("Login fail! Try again."),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              ),
            context.read<LoginBloc>().add(LoginSubmitFailure())
          }
      },
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
                        onPressed: null,
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
                const LoginListButton(),
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
        ),
      ),
    );
  }
}
