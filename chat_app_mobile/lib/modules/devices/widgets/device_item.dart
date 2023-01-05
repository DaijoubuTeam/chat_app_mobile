import 'package:chat_app_mobile/modules/devices/bloc/device_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({super.key, required this.deviceId, this.deviceName});

  final String deviceId;
  final String? deviceName;

  void _handleDeletDevice(BuildContext ctx, String deviceId) {
    ctx.read<DeviceBloc>().add(DeviceDeleted(deviceId: deviceId));
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _handleDeletDevice(context, deviceId),
            backgroundColor: Colors.red[400]!,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey[200]!,
            ),
          ),
        ),
        child: ListTile(
          minVerticalPadding: 20,
          leading: const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.android,
              color: Colors.white,
            ),
          ),
          title: Text(
            deviceName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // subtitle: Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Text(
          //     subTitle ?? '',
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
        ),
      ),
    );
  }
}
