// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMessage _$NewMessageFromJson(Map<String, dynamic> json) => NewMessage(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String?,
      from: json['from'] == null
          ? null
          : User.fromJson(json['from'] as Map<String, dynamic>),
      isMe: json['isMe'] as bool?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      readed: (json['readed'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$NewMessageToJson(NewMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'from': instance.from,
      'isMe': instance.isMe,
      'content': instance.content,
      'readed': instance.readed?.toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
