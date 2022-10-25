part of 'friend_profile_bloc.dart';

class FriendProfileState extends Equatable {
  const FriendProfileState({
    this.uid = '',
    this.email = '',
    this.fullname = '',
    this.phone = '',
    this.about = '',
    this.avatar = '',
  });

  final String uid;
  final String email;
  final String fullname;
  final String phone;
  final String about;
  final String avatar;

  FriendProfileState copyWith({
    String? uid,
    String? email,
    String? fullname,
    String? phone,
    String? about,
    String? avatar,
  }) {
    return FriendProfileState(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        avatar: avatar ?? this.avatar);
  }

  @override
  List<Object> get props => [uid, email, fullname, phone, about, avatar];
}
