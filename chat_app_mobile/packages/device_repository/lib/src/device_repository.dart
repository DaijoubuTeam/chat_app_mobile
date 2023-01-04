import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import 'models/models.dart';

class DeviceRepository {
  DeviceRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<Device>> getChatRoom(String bearerToken, String adminId) async {
    final List<chat_app_api.Device> devicesApi =
        await _chatAppApi.getDevices(bearerToken);

    final devicesRepo =
        devicesApi.map((deviceApi) => deviceApi.toRepositoryDevice()).toList();

    return devicesRepo;
  }

  Future<bool> createNewChatRoom(
    String bearerToken,
    String deviceId,
    String name,
    String fcmToken,
  ) async {
    return await _chatAppApi.postDevice(
      bearerToken,
      deviceId,
      name,
      fcmToken,
    );
  }

  Future<bool> deleteDe(
    String bearerToken,
    String deviceId,
  ) async {
    return await _chatAppApi.deleteUserDevice(
      bearerToken,
      deviceId,
    );
  }
}

extension on chat_app_api.Device {
  Device toRepositoryDevice() {
    final device = Device(
      id: id,
      name: name,
    );
    return device;
  }
}
