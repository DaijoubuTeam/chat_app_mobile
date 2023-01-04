import 'package:chat_app_mobile/modules/devices/view/device_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardDevices extends StatelessWidget {
  const CardDevices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.devices_outlined,
              color: Colors.black,
            )
          ],
        ),
        minLeadingWidth: 16,
        title: const Text(
          'Devices',
          style: TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: (() {
          context.pushNamed(DevicePage.namePage);
        }),
      ),
    );
  }
}
