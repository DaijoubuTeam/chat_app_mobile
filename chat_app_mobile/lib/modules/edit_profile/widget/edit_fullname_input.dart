import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
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
      child: OutlineInputBorderCustom(
        inputController: fullnameInputController,
        inputType: TextInputType.name,
        labelText: 'Full name',
        icon: const Icon(Icons.person),
      ),
    );
  }

  @override
  void dispose() {
    fullnameInputController.dispose();
    super.dispose();
  }
}
