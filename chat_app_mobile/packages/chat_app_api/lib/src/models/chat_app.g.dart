// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApp _$ChatAppFromJson(Map<String, dynamic> json) => ChatApp(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String,
      from: json['from'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChatAppToJson(ChatApp instance) => <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'from': instance.from,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
