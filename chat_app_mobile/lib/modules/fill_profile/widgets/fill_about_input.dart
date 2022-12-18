import 'package:chat_app_mobile/common/widgets/stateless/text_fields/multiline_input_border.dart';
import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillProfileAboutInput extends StatefulWidget {
  const FillProfileAboutInput({super.key});

  @override
  State<FillProfileAboutInput> createState() => _FillProfileAboutInputState();
}

class _FillProfileAboutInputState extends State<FillProfileAboutInput> {
  TextEditingController aboutInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    aboutInputController.addListener(() => context
        .read<FillProfileBloc>()
        .add(FillProfileAboutChanged(aboutInputController.text)));

    return BlocListener<FillProfileBloc, FillProfileState>(
      listenWhen: (previous, current) => previous.about != current.about,
      listener: (context, state) {
        if (state.about != null) {
          aboutInputController.text = state.about!;
        }

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

  @override
  void dispose() {
    aboutInputController.dispose();
    super.dispose();
  }
}
