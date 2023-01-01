import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String? username;
  final String? fullname;
  final String? avatar;
  final String? phone;
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
    this.personalChatRoomId,
    this.isFriend,
    this.isSelf,
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
    String? personalChatRoomId,
    bool? isFriend,
    bool? isSelf,
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
        personalChatRoomId: personalChatRoomId ?? this.personalChatRoomId,
        isFriend: isFriend ?? this.isFriend,
        isSelf: isSelf ?? this.isSelf,
      );

  static final empty = User(uid: '');

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
