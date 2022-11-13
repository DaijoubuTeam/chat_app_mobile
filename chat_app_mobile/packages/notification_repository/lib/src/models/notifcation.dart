import './models.dart';

class Notification {
  final String id;
  final String? notifyType;
  final bool? readed;
  final User? notificationSender;
  final User? notificationReceiver;
  final String? chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;

  Notification({
    required this.id,
    this.notifyType,
    this.readed = false,
    this.notificationSender,
    this.notificationReceiver,
    this.chatRoomId,
    this.chatRoomAvatar,
    this.chatRoomName,
  });

  Notification copyWith({
    String? id,
    String? notifyType,
    bool? readed,
    User? notificationSender,
    User? notificationReceiver,
    String? chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
  }) =>
      Notification(
          id: id ?? this.id,
          notifyType: notifyType ?? this.notifyType,
          readed: readed ?? this.readed,
          notificationSender: notificationSender ?? this.notificationSender,
          notificationReceiver:
              notificationReceiver ?? this.notificationReceiver,
          chatRoomId: chatRoomId ?? this.chatRoomId,
          chatRoomName: chatRoomName ?? this.chatRoomName,
          chatRoomAvatar: chatRoomAvatar ?? this.chatRoomAvatar);

  static final empty = Notification(id: '');
}
