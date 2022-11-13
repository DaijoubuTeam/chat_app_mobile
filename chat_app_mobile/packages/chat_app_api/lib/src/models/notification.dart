import './models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String? notifyType;
  final bool? readed;
  final User? notificationSender;
  final User? notificationReceiver;
  final ChatRoom? chatRoom;

  Notification({
    required this.id,
    this.notifyType,
    this.readed = false,
    this.notificationSender,
    this.notificationReceiver,
    this.chatRoom,
  });

  Notification copyWith({
    String? id,
    String? notifyType,
    bool? readed,
    User? notificationSender,
    User? notificationReceiver,
    ChatRoom? chatRoom,
  }) =>
      Notification(
        id: id ?? this.id,
        notifyType: notifyType ?? this.notifyType,
        readed: readed ?? this.readed,
        notificationSender: notificationSender ?? this.notificationSender,
        notificationReceiver: notificationReceiver ?? this.notificationReceiver,
      );

  static final empty = Notification(id: '');

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
