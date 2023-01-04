import 'package:chat_app_mobile/modules/devices/bloc/device_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentDeviceItem extends StatelessWidget {
  const CurrentDeviceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        final currentDevice = (state as DeviceGetListSuccess).currentDevice;
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.android,
                  color: Colors.white,
                ),
              ),
              title: Text(
                currentDevice?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
