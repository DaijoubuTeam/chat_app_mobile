import 'package:hive/hive.dart';

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

  User({
    required this.uid,
    this.username,
    this.fullname,
    this.avatar,
    this.phone,
    this.about,
    this.email,
  });

  User copyWith({
    String? uid,
    String? username,
    String? fullname,
    String? avatar,
    String? phone,
    String? about,
    String? email,
  }) =>
      User(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        fullname: fullname ?? this.fullname,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        email: email ?? this.email,
      );

  static final empty = User(uid: '');
}
