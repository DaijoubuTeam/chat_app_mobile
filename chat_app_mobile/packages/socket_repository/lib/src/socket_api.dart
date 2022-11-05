import 'dart:developer';

import 'socket_stream_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketApi {
  static final SocketApi _socketApi = SocketApi._internal();

  // An internal private constructor to access it for only once for static instance of class.
  SocketApi._internal();

  // Factry constructor to retutn same static instance everytime you create any object.
  factory SocketApi() {
    return _socketApi;
  }

  static IO.Socket socket = IO.io(
    'http://localhost:80',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect() // for Flutter or Dart VM
        .build(),
  );

  static void init() {
    log('socket init connected: ${socket.connected}');
    if (socket.connected == false) {
      socket.connect();
      socket.on('server:connected', (dynamic data) {
        log(
          'socket instance created and connected',
        );
        // socket.emit(
        //   'user:connected',
        //   <dynamic, dynamic>{'user': Environment.user},
        // );
      });
      // socket.on('unauthorized', (dynamic data) {
      //   print('Unauthorized');
      // });
      // socket.onError(
      //   (dynamic error) => {print(error), print('socket error')},
      // );
      // socket.onDisconnect((dynamic data) {
      //   print('socket instance disconnected');
      // });
    } else {
      log('socket instance already connected');
    }
  }

  //All socket related functions
  static Stream<String> getRegister(String uid) async* {
    final streamSocket = StreamSocketController<String>();
    try {
      socket.emit('register', {'uid': uid});
      socket.on('register', (data) {
        log(data.toString(), name: "register data");
        streamSocket.addResponse(data);
      });
      yield* streamSocket.getResponse;
    } catch (e) {
      log(e.toString(), name: "getRegister");
    }
  }
}
