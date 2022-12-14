import 'package:chat_app_mobile/common/widgets/stateless/buttons/elevated_button.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hide_keyboard.dart';

class EditSubmitButton extends StatelessWidget {
  const EditSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButtonCustom(
        onPressed: () => {
          SettingsKeyboard.hideKeyBoard(context),
          context.read<EditProfileBloc>().add(EditProfileFormSubmited()),
        },
        text: 'Done',
      ),
    );
  }
}
