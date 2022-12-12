import 'dart:async';

class SelectNotificationStream {
  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  static String normalNotification = "normal-notification";
}
