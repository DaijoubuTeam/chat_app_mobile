import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:device_repository/device_repository.dart';
import 'package:equatable/equatable.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc({
    required DeviceRepository deviceRepository,
    required AuthRepository authRepository,
  })  : _deviceRepository = deviceRepository,
        _authRepository = authRepository,
        super(DeviceGetListInLoading()) {
    on<DeviceInited>(_onDeviceInited);
  }

  final DeviceRepository _deviceRepository;
  final AuthRepository _authRepository;

  Future<void> _onDeviceInited(
      DeviceInited event, Emitter<DeviceState> emit) async {
    // try {

    // } catch (err) {

    // }
    return;
  }
}
