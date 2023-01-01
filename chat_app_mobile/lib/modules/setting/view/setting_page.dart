import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/setting/bloc/setting_bloc.dart';
import 'package:chat_app_mobile/modules/setting/widgets/setting_action.dart';
import 'package:chat_app_mobile/modules/setting/widgets/setting_logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../widgets/setting_infor_user.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc(
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>()),
      child: const SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      if (state is SettingPageGetInfoSuccess) {
        return Center(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    SettingInforUser(),
                    SizedBox(
                      height: 9,
                    ),
                    Divider(
                      height: 8.0,
                      thickness: 1.5,
                    ),
                    SettingAction(),
                    SizedBox(
                      height: 26,
                    ),
                    Divider(
                      height: 8.0,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SettingLogOutButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      if (state is SettingPageGetInfoFailure) {
        return const Center(
          child: Text("Somethings wrong!"),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
