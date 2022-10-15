import 'package:chat_app_mobile/common/widgets/staless/text_fields/custom_input_factory.dart';
import 'package:chat_app_mobile/common/widgets/staless/text_fields/email_input.dart';
import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEmailInput extends StatefulWidget {
  const EditEmailInput({super.key});

  @override
  State<EditEmailInput> createState() => _EditEmailInputState();
}

class _EditEmailInputState extends State<EditEmailInput> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.addListener(() => context
        .read<EditProfileBloc>()
        .add(EditProfileEmailChanged(emailController.text)));

    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: ((previous, current) => previous.email != current.email),
      listener: ((context, state) {
        emailController.text = state.email;
        emailController.selection = TextSelection.fromPosition(
            TextPosition(offset: emailController.text.length));
      }),
      child:
          CustomInputFactory.getCustomInput(InputType.email, emailController),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
