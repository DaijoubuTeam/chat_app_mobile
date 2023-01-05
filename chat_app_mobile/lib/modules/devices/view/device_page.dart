import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/devices/bloc/device_bloc.dart';
import 'package:chat_app_mobile/modules/devices/widgets/current_device.dart';
import 'package:chat_app_mobile/modules/devices/widgets/list_device.dart';
import 'package:device_repository/device_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  static const namePage = "devie-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceBloc(
        deviceRepository: context.read<DeviceRepository>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const DeviceView(),
    );
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Devices"),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceGetListSuccess) {
            return Center(
              child: Container(
                height: double.infinity,
                color: Theme.of(context).backgroundColor,
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<DeviceBloc>().add(DeviceInited());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Current session",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        const CurrentDeviceItem(),
                        const ListDevice(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is DeviceGetListInLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("Something wrong!"),
          );
        },
      ),
    );
  }
}
