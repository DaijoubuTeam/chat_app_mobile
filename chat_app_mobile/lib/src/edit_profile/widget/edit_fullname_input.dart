import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFullNameInput extends StatefulWidget {
  const EditFullNameInput({super.key});

  @override
  State<EditFullNameInput> createState() => _EditFullNameInputState();
}

class _EditFullNameInputState extends State<EditFullNameInput> {
  final _fullnameInputFormKey = GlobalKey<FormState>();
  TextEditingController fullnameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.fullname != previous.fullname,
      listener: (context, state) {
        fullnameInputController.text = state.fullname;
        fullnameInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: fullnameInputController.text.length));
      },
      child: TextField(
        key: _fullnameInputFormKey,
        controller: fullnameInputController,
        keyboardType: TextInputType.name,
        onChanged: ((fullname) {
          context
              .read<EditProfileBloc>()
              .add(EditProfileFullNameChanged(fullname));
        }),
        decoration: InputDecoration(
          labelText: 'Fullname',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.person),
          helperText: '',
        ),
      ),
    );
  }
}
