// import 'socket_stream_controller.dart';
import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_repository/src/models/new_message.dart';

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
    _socket.onConnecting((data) => print("connecting"));
    _socket.onConnect((data) => print("connected"));
    _socket.onDisconnect((data) => print("disconnect"));
    _socket.on('register', (data) => print(data));
    _socket.on('new-message', ((data) => socketNewMessage(data)));
  }

  StreamController<NewMessage> newMessageController =
      StreamController<NewMessage>.broadcast();

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
    print(newMessage);
    newMessageController.sink.add(newMessage);
    return newMessageController.stream;
  }

  void dispose() {
    newMessageController.close();
  }
}
