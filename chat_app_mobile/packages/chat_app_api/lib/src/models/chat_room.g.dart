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
      members: (json['members'] as List<dynamic>?)?.map((e) => e as String),
      admin: (json['admin'] as List<dynamic>?)?.map((e) => e as String),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'chatRoomName': instance.chatRoomName,
      'chatRoomAvatar': instance.chatRoomAvatar,
      'type': instance.type,
      'members': instance.members?.toList(),
      'admin': instance.admin?.toList(),
    };
