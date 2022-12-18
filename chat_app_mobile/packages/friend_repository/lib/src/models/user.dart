import 'package:model_repository/model_repository.dart';

class User extends IUser {
  User({
    required super.uid,
    super.username,
    super.fullname,
    super.avatar,
    super.phone,
    super.about,
    super.gender,
    super.email,
    super.isEmailVerified,
    super.isProfileFilled,
    super.friends,
    super.friendRequests,
    super.bans,
    super.personalChatRoomId,
  });

  User copyWith(
          {String? uid,
          String? username,
          String? fullname,
          String? avatar,
          String? phone,
          String? about,
          String? gender,
          String? email,
          bool? isEmailVerified,
          bool? isProfileFilled,
          List<String>? friends,
          List<String>? friendRequests,
          List<String>? bans,
          String? personalChatRoomId}) =>
      User(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        fullname: fullname ?? this.fullname,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isProfileFilled: isProfileFilled ?? this.isProfileFilled,
        friends: friends ?? this.friends,
        friendRequests: friendRequests ?? this.friendRequests,
        bans: bans ?? this.bans,
        personalChatRoomId: personalChatRoomId ?? this.personalChatRoomId,
      );

  static final empty = User(uid: '');
}
