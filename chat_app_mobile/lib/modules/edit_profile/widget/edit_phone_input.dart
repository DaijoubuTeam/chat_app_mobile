import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPhoneInput extends StatefulWidget {
  const EditPhoneInput({super.key});

  @override
  State<EditPhoneInput> createState() => _EditPhoneInputState();
}

class _EditPhoneInputState extends State<EditPhoneInput> {
  TextEditingController phoneInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneInputController.addListener(() => context
        .read<EditProfileBloc>()
        .add(EditProfilePhoneChanged(phoneInputController.text)));

    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.phone != current.phone,
      listener: (context, state) {
        phoneInputController.text = state.phone;
        phoneInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneInputController.text.length));
      },
      child: OutlineInputBorderCustom(
        inputController: phoneInputController,
        inputType: TextInputType.phone,
        labelText: 'Phone',
        icon: const Icon(Icons.phone),
      ),
    );
  }

  @override
  void dispose() {
    phoneInputController.dispose();
    super.dispose();
  }
}
