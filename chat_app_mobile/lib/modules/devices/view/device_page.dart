import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/devices/bloc/device_bloc.dart';
import 'package:device_repository/device_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

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
    return Container();
  }
}
