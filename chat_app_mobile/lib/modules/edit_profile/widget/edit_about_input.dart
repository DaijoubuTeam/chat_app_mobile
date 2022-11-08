import 'package:chat_app_mobile/common/widgets/stateless/text_fields/multiline_input_border.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAboutInput extends StatefulWidget {
  const EditAboutInput({super.key});

  @override
  State<EditAboutInput> createState() => _EditAboutInputState();
}

class _EditAboutInputState extends State<EditAboutInput> {
  TextEditingController aboutInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    aboutInputController.addListener(() => context
        .read<EditProfileBloc>()
        .add(EditProfileAboutChanged(aboutInputController.text)));

    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.about != current.about,
      listener: (context, state) {
        aboutInputController.text = state.about;
        aboutInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: aboutInputController.text.length));
      },
      child: MultilineInputBorderCustom(
        inputController: aboutInputController,
        labelText: 'About',
        icon: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
