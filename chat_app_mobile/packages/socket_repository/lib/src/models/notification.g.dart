// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as String,
      notifyType: json['notifyType'] as String?,
      readed: json['readed'] as bool? ?? false,
      notificationSender: json['notificationSender'] == null
          ? null
          : User.fromJson(json['notificationSender'] as Map<String, dynamic>),
      notificationReceiver: json['notificationReceiver'] == null
          ? null
          : User.fromJson(json['notificationReceiver'] as Map<String, dynamic>),
      chatRoom: json['chatRoom'] == null
          ? null
          : ChatRoom.fromJson(json['chatRoom'] as Map<String, dynamic>),
      message: json['message'] == null
          ? null
          : NewMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notifyType': instance.notifyType,
      'readed': instance.readed,
      'notificationSender': instance.notificationSender,
      'notificationReceiver': instance.notificationReceiver,
      'chatRoom': instance.chatRoom,
      'message': instance.message,
    };
