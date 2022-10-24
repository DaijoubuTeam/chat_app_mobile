import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_about_input.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_avatar.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_email_input.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_fullname_input.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_phone_input.dart';
import 'package:chat_app_mobile/modules/edit_profile/widget/edit_submit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class EditProfilePage extends StatelessWidget {
  static String namePage = 'EditProfilePage';

  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final userRepository = context.read<UserRepository>();

    return BlocProvider(
      create: (_) => EditProfileBloc(userRepository, authRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  EditAvatar(),
                  SizedBox(
                    height: 64,
                  ),
                  EditEmailInput(),
                  SizedBox(
                    height: 8,
                  ),
                  EditFullNameInput(),
                  SizedBox(
                    height: 8,
                  ),
                  EditPhoneInput(),
                  SizedBox(
                    height: 8,
                  ),
                  EditAboutInput(),
                  SizedBox(
                    height: 8,
                  ),
                  EditSubmitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
