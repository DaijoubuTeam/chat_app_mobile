import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:chat_app_mobile/modules/home/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/stateless/buttons/elevated_button.dart';
import '../../../utils/hide_keyboard.dart';

class FillSubmitForm extends StatelessWidget {
  const FillSubmitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FillProfileBloc, FillProfileState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          context.replaceNamed(HomePage.namePage);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButtonCustom(
          onPressed: () => {
            SettingsKeyboard.hideKeyBoard(context),
            context.read<FillProfileBloc>().add(FillProfileFormSubmited()),
          },
          text: 'Let\'s start',
        ),
      ),
    );
  }
}
