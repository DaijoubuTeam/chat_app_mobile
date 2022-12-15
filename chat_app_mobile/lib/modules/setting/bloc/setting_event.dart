part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class SettingPageInited extends SettingEvent {
  const SettingPageInited();

  @override
  List<Object?> get props => [];
}
