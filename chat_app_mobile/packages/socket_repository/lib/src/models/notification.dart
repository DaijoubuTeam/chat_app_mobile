import './models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String? notifyType;
  final bool? readed;
  //user
  final User? notificationSender;
  final User? notificationReceiver;
  //chat room
  final ChatRoom? chatRoom;
  //Message
  final NewMessage? message;

  Notification({
    required this.id,
    this.notifyType,
    this.readed = false,
    this.notificationSender,
    this.notificationReceiver,
    this.chatRoom,
    this.message,
  });

  Notification copyWith({
    String? id,
    String? notifyType,
    bool? readed,
    User? notificationSender,
    User? notificationReceiver,
    ChatRoom? chatRoom,
    NewMessage? message,
  }) =>
      Notification(
        id: id ?? this.id,
        notifyType: notifyType ?? this.notifyType,
        readed: readed ?? this.readed,
        notificationSender: notificationSender ?? this.notificationSender,
        notificationReceiver: notificationReceiver ?? this.notificationReceiver,
        chatRoom: chatRoom ?? this.chatRoom,
        message: message ?? this.message,
      );

  static final empty = Notification(id: '');

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
