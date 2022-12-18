import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/stateless/text_fields/outline_input_border_custom.dart';

class FillEmailInput extends StatefulWidget {
  const FillEmailInput({super.key});

  @override
  State<FillEmailInput> createState() => _FillEmailInputState();
}

class _FillEmailInputState extends State<FillEmailInput> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.addListener(() => context
        .read<FillProfileBloc>()
        .add(FillProfileEmailChanged(emailController.text)));

    return BlocListener<FillProfileBloc, FillProfileState>(
      listenWhen: ((previous, current) => previous.email != current.email),
      listener: ((context, state) {
        if (state.email != null) {
          emailController.text = state.email!;
        }

        emailController.selection = TextSelection.fromPosition(
            TextPosition(offset: emailController.text.length));
      }),
      child: OutlineInputBorderCustom(
        inputController: emailController,
        inputType: TextInputType.emailAddress,
        labelText: 'Email',
        icon: const Icon(Icons.email),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
