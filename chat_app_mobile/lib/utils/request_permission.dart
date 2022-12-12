import 'package:permission_handler/permission_handler.dart';

class RequestPermissionApp {
  static Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }
}
