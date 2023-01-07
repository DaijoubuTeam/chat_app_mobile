import 'package:chat_app_mobile/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/full_screen_image/full_screen_image.dart';
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imageUrl: state.user.avatar!)));
                },
                child: CircleAvatarCustom(
                  urlImage: state.user.avatar,
                  widthImage: 120.w,
                  heightImage: 120.h,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                state.user.fullname ?? '',
                style: TextStyle(
                  fontSize: 24.sp,
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
                      color: Colors.black,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: Text(
                  state.user.email ?? 'No email',
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
                      color: Colors.black,
                    ),
                  ],
                ),
                minLeadingWidth: 24,
                title: (state.user.phone == "" || state.user.phone == null)
                    ? Text(
                        'No phone',
                        style: TextStyle(
                            fontSize: 16.sp, fontStyle: FontStyle.italic),
                      )
                    : Text(
                        state.user.phone ?? "",
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
