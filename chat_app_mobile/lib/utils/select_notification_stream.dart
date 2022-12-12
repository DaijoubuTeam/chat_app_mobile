import 'dart:async';

class SelectNotificationStream {
  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  static String normalNotification = "normal-notification";

  static const String acceptCallId = "accept-call-id";
  static const String deniedCallId = "denied-call-id";
}
