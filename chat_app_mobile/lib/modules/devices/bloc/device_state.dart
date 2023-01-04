part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object?> get props => [];
}

class DeviceGetListInLoading extends DeviceState {}

class DeviceGetListSuccess extends DeviceState {
  const DeviceGetListSuccess({required this.listDevice});

  final List<Device> listDevice;

  @override
  List<Object?> get props => [listDevice];
}

class DeviceGetListFail extends DeviceState {}
