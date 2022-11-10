// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMessage _$NewMessageFromJson(Map<String, dynamic> json) => NewMessage(
      chatRoomId: json['chatRoomId'] as String?,
      from: json['from'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewMessageToJson(NewMessage instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'from': instance.from,
      'content': instance.content,
    };
