// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>)),
      chatrooms: (json['chatrooms'] as List<dynamic>?)
          ?.map((e) => ChatRoom.fromJson(e as Map<String, dynamic>)),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'users': instance.users.toList(),
      'chatrooms': instance.chatrooms.toList(),
      'messages': instance.messages.toList(),
    };
