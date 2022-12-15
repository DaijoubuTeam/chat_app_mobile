import 'dart:async';

class SelectNotificationStream {
  static final StreamController<NotificationData?> selectNotificationStream =
      StreamController<NotificationData?>.broadcast();

  static String normalNotification = "normal-notification";

  static const String acceptCallId = "accept-call-id";
  static const String deniedCallId = "denied-call-id";
}

class NotificationData {
  String? actionId;
  String type;

  NotificationData({this.actionId, required this.type});
}
