// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      uid: json['uid'] as String,
      gender: json['gender'] as String?,
      fullname: json['fullname'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      about: json['about'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'uid': instance.uid,
      'gender': instance.gender,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'about': instance.about,
      'email': instance.email,
    };
