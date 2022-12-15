// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String?,
      from: json['from'] == null
          ? null
          : User.fromJson(json['from'] as Map<String, dynamic>),
      content: json['content'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      readed: (json['readed'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'from': instance.from,
      'content': instance.content,
      'type': instance.type,
      'readed': instance.readed?.toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
