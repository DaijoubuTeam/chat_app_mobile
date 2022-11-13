part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.uid = '',
    this.email = '',
    this.fullname = '',
    this.phone = '',
    this.about = '',
    this.avatar = '',
    this.status = FormzStatus.pure,
  });

  final String uid;
  final String email;
  final String fullname;
  final String phone;
  final String about;
  final String avatar;
  final FormzStatus status;

  EditProfileState copyWith({
    String? uid,
    String? email,
    String? fullname,
    String? phone,
    String? about,
    String? avatar,
    FormzStatus? status,
  }) {
    return EditProfileState(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [uid, email, fullname, phone, about, avatar, status];
}
