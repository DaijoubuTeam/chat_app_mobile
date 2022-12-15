part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class SettingPageInitial extends SettingState {}

class SettingPageInLoading extends SettingState {}

class SettingPageGetInfoSuccess extends SettingState {
  const SettingPageGetInfoSuccess({required this.user});

  final auth_repo.User user;

  SettingPageGetInfoSuccess copyWith({auth_repo.User? user}) {
    return SettingPageGetInfoSuccess(user: user ?? this.user);
  }
}

class SettingPageGetInfoFailure extends SettingState {}
