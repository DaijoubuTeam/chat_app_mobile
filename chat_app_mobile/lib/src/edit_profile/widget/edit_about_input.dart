import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAboutInput extends StatefulWidget {
  const EditAboutInput({super.key});

  @override
  State<EditAboutInput> createState() => _EditAboutInputState();
}

class _EditAboutInputState extends State<EditAboutInput> {
  final _aboutFormKey = GlobalKey<FormState>();
  TextEditingController aboutInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.about != current.about,
      listener: (context, state) {
        aboutInputController.text = state.about;
        aboutInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: aboutInputController.text.length));
      },
      child: TextField(
        key: _aboutFormKey,
        controller: aboutInputController,
        onChanged: ((about) {
          context.read<EditProfileBloc>().add(EditProfileAboutChanged(about));
        }),
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'About',
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Align(
            alignment: Alignment.topCenter,
            widthFactor: 1.0,
            heightFactor: 3.3,
            child: Icon(Icons.info_outline_rounded),
          ),
          helperText: '',
        ),
      ),
    );
  }
}
