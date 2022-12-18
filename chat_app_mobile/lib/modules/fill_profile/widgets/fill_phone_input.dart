import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/stateless/text_fields/outline_input_border_custom.dart';

class FillPhoneInput extends StatefulWidget {
  const FillPhoneInput({super.key});

  @override
  State<FillPhoneInput> createState() => _FillPhoneInputState();
}

class _FillPhoneInputState extends State<FillPhoneInput> {
  TextEditingController phoneInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneInputController.addListener(() => context
        .read<FillProfileBloc>()
        .add(FillProfilePhoneChanged(phoneInputController.text)));

    return BlocListener<FillProfileBloc, FillProfileState>(
      listenWhen: (previous, current) => previous.phone != current.phone,
      listener: (context, state) {
        if (state.phone != null) {
          phoneInputController.text = state.phone!;
        }
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
