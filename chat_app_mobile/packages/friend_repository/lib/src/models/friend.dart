class Friend {
  final String uid;
  final String? gender;
  final String? fullname;
  final String? avatar;
  final String? phone;
  final String? about;
  final String? email;

  Friend({
    required this.uid,
    this.gender,
    this.fullname,
    this.avatar,
    this.phone,
    this.about,
    this.email,
  });

  Friend copyWith({
    String? uid,
    String? gender,
    String? fullname,
    String? avatar,
    String? phone,
    String? about,
    String? email,
  }) =>
      Friend(
        uid: uid ?? this.uid,
        gender: gender ?? this.gender,
        fullname: fullname ?? this.fullname,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        email: email ?? this.email,
      );

  static final empty = Friend(uid: '');
}
