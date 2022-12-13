import 'package:chat_app_mobile/utils/select_notification_stream.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum NotifiType {
  defaultNotifi("default-notifi"),
  mention("mention"),
  friendRequest("friend-request"),
  chatRoomInvitation("chat-room-invitation");

  const NotifiType(this.type);
  final String type;

  @override
  String toString() => type;
}

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  //for ios
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    showNotification(
      id: id,
      title: title ?? '',
      body: body ?? '',
      payload: payload ?? '',
    );
  }

  Future<void> initialize() async {
    _localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  static void _onSelectNotification(NotificationResponse details) {
    SelectNotificationStream.selectNotificationStream.add(
        NotificationData(actionId: details.actionId, type: details.payload!));
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      autoCancel: false,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          SelectNotificationStream.acceptCallId,
          "Accept",
          showsUserInterface: true,
          cancelNotification: true,
        ),
        AndroidNotificationAction(
          SelectNotificationStream.deniedCallId,
          "Deny",
          cancelNotification: true,
          showsUserInterface: true,
        ),
      ],
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String type = "default-notifi",
  }) async {
    final details = await _notificationDetails();
    await _localNotificationPlugin.show(id, title, body, details,
        payload: payload);
  }

  Future<void> showCallNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String type = "default-notifi",
  }) async {
    final details = await _notificationDetails();
    await _localNotificationPlugin.show(id, title, body, details,
        payload: payload);
  }
}
