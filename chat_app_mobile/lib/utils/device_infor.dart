import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfor {
  static Future<String?> getAndroidId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.androidId;
    }
    return null;
  }

  static Future<String?> getDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;

      return iosDeviceInfo.model;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.model;
    }
    return null;
  }
}
