part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfilePageInited extends EditProfileEvent {}

class EditProfileEmailChanged extends EditProfileEvent {
  const EditProfileEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class EditProfileFullNameChanged extends EditProfileEvent {
  const EditProfileFullNameChanged(this.fullname);
  final String fullname;

  @override
  List<Object> get props => [fullname];
}

class EditProfilePhoneChanged extends EditProfileEvent {
  const EditProfilePhoneChanged(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

class EditProfileAboutChanged extends EditProfileEvent {
  const EditProfileAboutChanged(this.about);
  final String about;

  @override
  List<Object> get props => [about];
}

class EditProfileFormSubmited extends EditProfileEvent {}
