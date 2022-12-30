import 'package:chat_app_mobile/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/stateless/avatars/circle_avatar_network.dart';

class SettingInforUser extends StatelessWidget {
  const SettingInforUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingPageGetInfoSuccess) {
          return Column(
            children: <Widget>[
              CircleAvatarCustom(
                urlImage: state.user.avatar,
                widthImage: 120.w,
                heightImage: 120.h,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                state.user.fullname ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.mail_outline,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: Text(
                  state.user.email ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.phone_outlined,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: Text(
                  state.user.phone ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
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
      },
    );
  }
}
