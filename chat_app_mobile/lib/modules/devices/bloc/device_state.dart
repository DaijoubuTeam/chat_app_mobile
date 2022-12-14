part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object?> get props => [];
}

class DeviceGetListInLoading extends DeviceState {}

class DeviceGetListSuccess extends DeviceState {
  const DeviceGetListSuccess({required this.listDevice, this.currentDevice});

  final List<Device> listDevice;
  final Device? currentDevice;

  @override
  List<Object?> get props => [listDevice];
}

class DeviceGetListFail extends DeviceState {}
