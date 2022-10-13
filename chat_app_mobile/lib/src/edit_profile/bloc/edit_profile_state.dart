part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.email = '',
    this.fullname = '',
    this.phone = '',
    this.about = '',
    this.avatar = '',
  });

  final String email;
  final String fullname;
  final String phone;
  final String about;
  final String avatar;

  EditProfileState copyWith({
    String? email,
    String? fullname,
    String? phone,
    String? about,
    String? avatar,
  }) {
    return EditProfileState(
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        avatar: avatar ?? this.avatar);
  }

  @override
  List<Object> get props => [email, fullname, phone, about, avatar];
}

class EditProfileInitial extends EditProfileState {}
