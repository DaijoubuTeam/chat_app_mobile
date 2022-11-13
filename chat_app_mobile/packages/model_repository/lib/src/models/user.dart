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
  })  : friends = friends ?? List.unmodifiable([]),
        friendRequests = friendRequests ?? List.unmodifiable([]),
        bans = bans ?? List.unmodifiable([]);

  // User copyWith({
  //   String? uid,
  //   String? username,
  //   String? fullname,
  //   String? avatar,
  //   String? phone,
  //   String? about,
  //   String? email,
  //   bool? isEmailVerified,
  //   bool? isProfileFilled,
  //   List<String>? friends,
  //   List<String>? friendRequests,
  //   List<String>? bans,
  // }) =>
  //     User(
  //       uid: uid ?? this.uid,
  //       username: username ?? this.username,
  //       fullname: fullname ?? this.fullname,
  //       avatar: avatar ?? this.avatar,
  //       phone: phone ?? this.phone,
  //       about: about ?? this.about,
  //       email: email ?? this.email,
  //       isEmailVerified: isEmailVerified ?? this.isEmailVerified,
  //       isProfileFilled: isProfileFilled ?? this.isProfileFilled,
  //       friends: friends ?? this.friends,
  //       friendRequests: friendRequests ?? this.friendRequests,
  //       bans: bans ?? this.bans,
  //     );
}
