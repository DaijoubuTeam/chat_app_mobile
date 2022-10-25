import 'package:hive/hive.dart';

export './user.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? fullname;
  @HiveField(3)
  final String? avatar;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  final String? about;
  @HiveField(6)
  final String? email;
  final bool? isEmailVerified;
  final bool? isProfileFilled;
  final Iterable<String> friends;
  final Iterable<String> friendRequests;
  final Iterable<String> bans;

  User({
    required this.uid,
    this.username,
    this.fullname,
    this.avatar,
    this.phone,
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

  User copyWith({
    String? uid,
    String? username,
    String? fullname,
    String? avatar,
    String? phone,
    String? about,
    String? email,
    bool? isEmailVerified,
    bool? isProfileFilled,
    List<String>? friends,
    List<String>? friendRequests,
    List<String>? bans,
  }) =>
      User(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        fullname: fullname ?? this.fullname,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        email: email ?? this.email,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isProfileFilled: isProfileFilled ?? this.isProfileFilled,
        friends: friends ?? this.friends,
        friendRequests: friendRequests ?? this.friendRequests,
        bans: bans ?? this.bans,
      );

  static final empty = User(uid: '');
}
