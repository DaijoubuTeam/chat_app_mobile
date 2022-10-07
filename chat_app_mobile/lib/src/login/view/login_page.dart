import 'package:chat_app_mobile/src/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => LoginBloc(),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Sign-in to your account'),
          const SizedBox(
            height: 32,
          ),
          const _EmailInput(),
          const SizedBox(
            height: 8,
          ),
          const _PasswordInput(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              TextButton(onPressed: null, child: Text('Forgot Password'))
            ],
          ),
          const _LoginButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: ((previos, current) => previos.email != current.email),
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) =>
                context.read<LoginBloc>().add(EmailChanged(email)),
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              helperText: '',
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_TextField'),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (password) =>
              context.read<LoginBloc>().add(PasswordChanged(password)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(
      onPressed: null,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
