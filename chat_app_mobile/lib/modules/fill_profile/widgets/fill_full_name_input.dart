import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/stateless/text_fields/outline_input_border_custom.dart';

class FillFullNameInput extends StatefulWidget {
  const FillFullNameInput({super.key});

  @override
  State<FillFullNameInput> createState() => _FillFullNameInputState();
}

class _FillFullNameInputState extends State<FillFullNameInput> {
  TextEditingController fullnameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fullnameInputController.addListener(
      () => context.read<FillProfileBloc>().add(
            FillProfileFullNameChanged(fullnameInputController.text),
          ),
    );

    return BlocListener<FillProfileBloc, FillProfileState>(
      listenWhen: (previous, current) => previous.fullname != current.fullname,
      listener: (context, state) {
        if (state.fullname != null) {
          fullnameInputController.text = state.fullname!;
        }

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
