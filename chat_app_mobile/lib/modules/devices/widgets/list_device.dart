import 'package:chat_app_mobile/modules/devices/bloc/device_bloc.dart';
import 'package:chat_app_mobile/modules/devices/widgets/device_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListDevice extends StatelessWidget {
  const ListDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        final listDevice = (state as DeviceGetListSuccess).listDevice;
        if (true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Active sessions (${listDevice.length})",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DeviceItem(
                        deviceId: state.listDevice[index].id,
                        deviceName: state.listDevice[index].name,
                      );
                    },
                    itemCount: state.listDevice.length,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
