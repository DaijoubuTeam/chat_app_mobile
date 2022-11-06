// import 'socket_stream_controller.dart';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketAPI {
  final IO.Socket _socket;
  SocketAPI._()
      : _socket = IO.io(
          'http://localhost:80',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect() // for Flutter or Dart VM
              // .enableForceNew()
              .build(),
        ) {
    _socket.onConnecting((data) => print("connecting"));
    _socket.onConnect((data) => print("connected"));
    _socket.onDisconnect((data) => print("disconnect"));
    _socket.on('register', (data) => print(data));
  }

  static SocketAPI? _socketApi;
  static SocketAPI get SocketApi {
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
      SocketAPI._socketApi = null;
    }
  }

  void socketRegister(String uid) {
    if (_socket.connected && uid.isNotEmpty) {
      log("registering", name: "socketRegister");
      _socket.emit('register', {'uid': uid});
    }
  }
}
