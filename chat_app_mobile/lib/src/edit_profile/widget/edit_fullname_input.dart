import 'package:chat_app_mobile/src/common/widgets/staless/text_fields/name_input.dart';
import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFullNameInput extends StatefulWidget {
  const EditFullNameInput({super.key});

  @override
  State<EditFullNameInput> createState() => _EditFullNameInputState();
}

class _EditFullNameInputState extends State<EditFullNameInput> {
  TextEditingController fullnameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fullnameInputController.addListener(
      () => context.read<EditProfileBloc>().add(
            EditProfileFullNameChanged(fullnameInputController.text),
          ),
    );

    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.fullname != current.fullname,
      listener: (context, state) {
        fullnameInputController.text = state.fullname;
        fullnameInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: fullnameInputController.text.length));
      },
      child: NameInput(nameInputController: fullnameInputController),
    );
  }
}
