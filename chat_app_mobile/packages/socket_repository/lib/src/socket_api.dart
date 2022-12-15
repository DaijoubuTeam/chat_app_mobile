// import 'socket_stream_controller.dart';
import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_repository/socket_repository.dart';

class SocketAPI {
  final IO.Socket _socket;

  SocketAPI._()
      : _socket = IO.io(
          'https://alpha.chatapp.daijoubuteam.xyz',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect() // for Flutter or Dart VM
              // .enableForceNew()
              .build(),
        ) {
    _socket.onConnecting((data) => log("connecting"));
    _socket.onConnect((data) => log("connected"));
    _socket.onDisconnect((data) => log("disconnect"));
    _socket.on('register', (data) => log(data));
    _socket.on('new-message', ((data) => socketNewMessage(data)));
    _socket.on('new-notification', ((data) => socketNewNotification(data)));
    _socket.on('webrtc', ((data) => socketNewCallWebRTC(data)));
  }

  StreamController<NewMessage> newMessageController =
      StreamController<NewMessage>.broadcast();

  StreamController<Notification> newNotificationController =
      StreamController<Notification>.broadcast();

  StreamController<dynamic> webRTCStream =
      StreamController<dynamic>.broadcast();

  static SocketAPI? _socketApi;

  static SocketAPI get socketApi {
    _socketApi ??= SocketAPI._();
    return _socketApi!;
  }

  IO.Socket socketConnect() {
    if (!_socket.connected) {
      return _socket.connect();
    }
    return _socket;
  }

  void socketDisconnected() {
    if (!_socket.disconnected) {
      _socket.dispose();
      // dispose controller
      dispose();
      SocketAPI._socketApi = null;
    }
  }

  void socketRegister(String uid) {
    if (_socket.connected && uid.isNotEmpty) {
      log("registering", name: "socketRegister");
      _socket.emit('register', {'uid': uid});
    }
  }

  Stream<NewMessage> socketNewMessage(dynamic data) {
    final newMessage = NewMessage.fromJson(data);
    newMessageController.sink.add(newMessage);
    return newMessageController.stream;
  }

  Stream<Notification> socketNewNotification(dynamic data) {
    log(data.toString(), name: "new notification");
    final newNotification = Notification.fromJson(data);
    newNotificationController.sink.add(newNotification);
    return newNotificationController.stream;
  }

  Stream<dynamic> socketNewCallWebRTC(dynamic data) {
    webRTCStream.sink.add(data);
    return webRTCStream.stream;
  }

  void dispose() {
    newMessageController.close();
    newNotificationController.close();
  }
}
