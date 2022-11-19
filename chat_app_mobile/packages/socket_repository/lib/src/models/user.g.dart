// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      username: json['username'] as String?,
      fullname: json['fullname'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      about: json['about'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isProfileFilled: json['isProfileFilled'] as bool?,
      friends: (json['friends'] as List<dynamic>?)?.map((e) => e as String),
      friendRequests:
          (json['friendRequests'] as List<dynamic>?)?.map((e) => e as String),
      bans: (json['bans'] as List<dynamic>?)?.map((e) => e as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'gender': instance.gender,
      'about': instance.about,
      'email': instance.email,
      'isEmailVerified': instance.isEmailVerified,
      'isProfileFilled': instance.isProfileFilled,
      'friends': instance.friends.toList(),
      'friendRequests': instance.friendRequests.toList(),
      'bans': instance.bans.toList(),
    };
