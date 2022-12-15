// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      chatRoomId: json['chatRoomId'] as String,
      chatRoomName: json['chatRoomName'] as String?,
      chatRoomAvatar: json['chatRoomAvatar'] as String?,
      type: json['type'] as String?,
      latestMessage: json['latestMessage'] == null ||
              json['latestMessage'].runtimeType == String
          ? null
          : Message.fromJson(json['latestMessage'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>)),
      admin: (json['admin'] as List<dynamic>?)?.map((e) => e as String),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'chatRoomAvatar': instance.chatRoomAvatar,
      'members': instance.members.toList(),
      'admin': instance.admin.toList(),
      'latestMessage': instance.latestMessage,
      'type': instance.type,
    };
