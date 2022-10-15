import 'package:chat_app_mobile/common/widgets/staless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailInput extends StatefulWidget {
  const LoginEmailInput({super.key});
  @override
  State<LoginEmailInput> createState() => _LoginEmailInputState();
}

class _LoginEmailInputState extends State<LoginEmailInput> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _emailController.addListener(
      () => context.read<LoginBloc>().add(EmailChanged(_emailController.text)),
    );
    // return BlocBuilder<LoginBloc, LoginState>(
    //   buildWhen: ((previos, current) => previos.email != current.email),
    //   builder: (context, state) {
    //     return TextField(
    //       key: const Key('loginForm_emailInput_textField'),
    //       keyboardType: TextInputType.emailAddress,
    //       onChanged: (email) =>
    //           context.read<LoginBloc>().add(EmailChanged(email)),
    //       decoration: InputDecoration(
    //         labelText: 'Email',
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //         helperText: '',
    //       ),
    //     );
    //   },
    // );
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: ((previous, current) => previous.email != current.email),
      listener: (context, state) {},
      child: OutlineInputBorderCustom(
        inputController: _emailController,
        inputType: TextInputType.emailAddress,
        labelText: 'Email',
        icon: const Icon(Icons.email),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
