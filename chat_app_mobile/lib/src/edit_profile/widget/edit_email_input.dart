import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEmailInput extends StatefulWidget {
  const EditEmailInput({super.key});

  @override
  State<EditEmailInput> createState() => _EditEmailInputState();
}

class _EditEmailInputState extends State<EditEmailInput> {
  final _emailInputFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: ((previous, current) => previous.email != current.email),
      listener: ((context, state) {
        emailController.text = state.email;
        emailController.selection = TextSelection.fromPosition(
            TextPosition(offset: emailController.text.length));
      }),
      child: TextFormField(
        key: _emailInputFormKey,
        controller: emailController,
        onChanged: ((email) {
          context.read<EditProfileBloc>().add(EditProfileEmailChanged(email));
        }),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.email),
          helperText: '',
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
