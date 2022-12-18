part of 'fill_profile_bloc.dart';

abstract class FillProfileEvent extends Equatable {
  const FillProfileEvent();

  @override
  List<Object?> get props => [];
}

class FillProfilePageInited extends FillProfileEvent {}

class FillProfileEmailChanged extends FillProfileEvent {
  const FillProfileEmailChanged(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

class FillProfileFullNameChanged extends FillProfileEvent {
  const FillProfileFullNameChanged(this.fullname);
  final String fullname;

  @override
  List<Object?> get props => [fullname];
}

class FillProfilePhoneChanged extends FillProfileEvent {
  const FillProfilePhoneChanged(this.phone);
  final String phone;

  @override
  List<Object?> get props => [phone];
}

class FillProfileAvatarChanged extends FillProfileEvent {
  const FillProfileAvatarChanged(this.urlImage);
  final String? urlImage;

  @override
  List<Object?> get props => [urlImage];
}

class FillProfileAboutChanged extends FillProfileEvent {
  const FillProfileAboutChanged(this.about);
  final String about;

  @override
  List<Object?> get props => [about];
}

class FillProfileFormSubmited extends FillProfileEvent {}
