import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/fill_profile/bloc/fill_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:user_repository/user_repository.dart';

import '../../../common/widgets/stateless/app_bar/app_bar_title.dart';
import '../../../utils/hide_keyboard.dart';
import '../widgets/fill_about_input.dart';
import '../widgets/fill_avatar.dart';
import '../widgets/fill_email_input.dart';
import '../widgets/fill_full_name_input.dart';
import '../widgets/fill_phone_input.dart';
import '../widgets/fill_submit_button.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({super.key});

  static const String namePage = "fillProfile";

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FillProfileBloc(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: const FillProfileView(),
    );
  }
}

class FillProfileView extends StatelessWidget {
  const FillProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Update your information",
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (() {
            SettingsKeyboard.hideKeyBoard(context);
          }),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 8,
                ),
                FillAvatar(),
                SizedBox(
                  height: 36,
                ),
                FillEmailInput(),
                SizedBox(
                  height: 8,
                ),
                FillFullNameInput(),
                SizedBox(
                  height: 8,
                ),
                FillPhoneInput(),
                SizedBox(
                  height: 8,
                ),
                FillProfileAboutInput(),
                SizedBox(
                  height: 8,
                ),
                FillSubmitForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
