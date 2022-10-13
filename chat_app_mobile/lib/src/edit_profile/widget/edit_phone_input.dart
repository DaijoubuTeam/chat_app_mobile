import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPhoneInput extends StatefulWidget {
  const EditPhoneInput({super.key});

  @override
  State<EditPhoneInput> createState() => _EditPhoneInputState();
}

class _EditPhoneInputState extends State<EditPhoneInput> {
  final _phoneFormKey = GlobalKey<FormState>();
  TextEditingController phoneInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.phone != previous.phone,
      listener: (context, state) {
        phoneInputController.text = state.fullname;
        phoneInputController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneInputController.text.length));
      },
      child: TextField(
        key: _phoneFormKey,
        controller: phoneInputController,
        keyboardType: TextInputType.phone,
        onChanged: ((phone) {
          context.read<EditProfileBloc>().add(EditProfilePhoneChanged(phone));
        }),
        decoration: InputDecoration(
          labelText: 'Phone',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.phone),
          helperText: '',
        ),
      ),
    );
  }
}
