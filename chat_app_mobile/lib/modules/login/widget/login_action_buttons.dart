import 'package:chat_app_mobile/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../common/widgets/stateless/divider_with_text_center.dart';
import 'login_list_button.dart';
import 'login_with_google_button.dart';

class LoginActionButtons extends StatelessWidget {
  const LoginActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: const [
            LoginListButton(),
            SizedBox(
              height: 8,
            ),
            DividerWithTextCenter(title: 'Or'),
            SizedBox(
              height: 8,
            ),
            LoginWithGoogleButton(),
          ],
        );
      },
    );
  }
}
