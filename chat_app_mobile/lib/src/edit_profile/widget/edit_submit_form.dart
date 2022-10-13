import 'package:chat_app_mobile/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSubmitButton extends StatelessWidget {
  const EditSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          context.read<EditProfileBloc>().add(EditProfileFormSubmited()),
        },
        // border radius
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Let\'s start',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
