import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:chat_app_mobile/utils/device_infor.dart';
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
    on<DeviceDeleted>(_onDeviceDeleted);

    add(DeviceInited());
  }

  final DeviceRepository _deviceRepository;
  final AuthRepository _authRepository;

  Future<void> _onDeviceInited(
      DeviceInited event, Emitter<DeviceState> emit) async {
    emit(DeviceGetListInLoading());
    try {
      final bearerToken = await _authRepository.bearToken;
      String? androidId = await DeviceInfor.getAndroidId();
      if (bearerToken != null && androidId != null) {
        final listDevice = await _deviceRepository.getDevices(bearerToken);

        final currentDevice =
            listDevice.firstWhere((element) => element.id == androidId);

        final activeDevices =
            listDevice.where((element) => element.id != androidId).toList();

        emit(DeviceGetListSuccess(
          listDevice: activeDevices,
          currentDevice: currentDevice,
        ));
      }
    } catch (_) {
      FlutterToastCustom.showToast("Something wrong! Try again", "error");
      emit(DeviceGetListFail());
    }
  }

  Future<void> _onDeviceDeleted(
      DeviceDeleted event, Emitter<DeviceState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null && event.deviceId != null) {
        final res = await _deviceRepository.deleteUserDevice(
          bearerToken,
          event.deviceId!,
        );

        if (res) {
          FlutterToastCustom.showToast("Delete device success", "success");
        } else {
          FlutterToastCustom.showToast("Delete device fail", "error");
        }
      }
    } catch (_) {
      FlutterToastCustom.showToast("Something wrong! Try again", "error");
    }
  }
}
