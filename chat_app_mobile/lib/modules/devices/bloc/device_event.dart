part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object?> get props => [];
}

class DeviceInited extends DeviceEvent {}

class DeviceDeleted extends DeviceEvent {
  const DeviceDeleted({required this.deviceId});

  final String? deviceId;

  @override
  List<Object?> get props => [deviceId];
}
