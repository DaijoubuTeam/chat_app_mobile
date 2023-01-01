export './user.dart';

abstract class IUser {
  final String uid;
  final String? username;
  final String? fullname;
  final String? avatar;
  final String? phone;
  final String? gender;
  final String? about;
  final String? email;
  final bool? isEmailVerified;
  final bool? isProfileFilled;
  final Iterable<String> friends;
  final Iterable<String> friendRequests;
  final Iterable<String> bans;
  final String? personalChatRoomId;
  final bool? isFriend;
  final bool? isSelf;

  IUser({
    required this.uid,
    this.username,
    this.fullname,
    this.avatar,
    this.phone,
    this.gender,
    this.about,
    this.email,
    this.isEmailVerified,
    this.isProfileFilled,
    Iterable<String>? friends,
    Iterable<String>? friendRequests,
    Iterable<String>? bans,
    this.isFriend,
    this.isSelf,
    this.personalChatRoomId,
  })  : friends = friends ?? List.unmodifiable([]),
        friendRequests = friendRequests ?? List.unmodifiable([]),
        bans = bans ?? List.unmodifiable([]);
}
