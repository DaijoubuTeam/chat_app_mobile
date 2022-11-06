import 'dart:developer';
import 'dart:io';

// import 'socket_stream_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketApi {
//   static final SocketApi _socketApi = SocketApi._internal();

//   // An internal private constructor to access it for only once for static instance of class.
//   SocketApi._internal();

//   // Factry constructor to retutn same static instance everytime you create any object.
//   factory SocketApi() {
//     return _socketApi;
//   }

//   static IO.Socket socket = IO.io(
//     'http://localhost:80',
//     IO.OptionBuilder()
//         .setTransports(['websocket'])
//         .disableAutoConnect() // for Flutter or Dart VM
//         // .enableForceNew()
//         .build(),
//   );

//   static void init() {
//     log('socket init connected: ${socket.connected}');
//     if (socket.connected == false) {
//       socket.connect();
//       socket.on('server:connected', (dynamic data) {
//         log(
//           'socket instance created and connected',
//         );
//         // socket.emit(
//         //   'user:connected',
//         //   <dynamic, dynamic>{'user': Environment.user},
//         // );
//       });
//       // socket.on('unauthorized', (dynamic data) {
//       //   print('Unauthorized');
//       // });
//       // socket.onError(
//       //   (dynamic error) => {print(error), print('socket error')},
//       // );
//       // socket.onDisconnect((dynamic data) {
//       //   print('socket instance disconnected');
//       // });
//     } else {
//       log('socket instance already connected');
//     }
//   }

//   //All socket related functions
//   static Stream<String> getRegister(String uid) async* {
//     final streamSocket = StreamSocketController<String>();
//     try {
//       socket.emit('register', {'uid': uid});
//       socket.on('register', (data) {
//         log(data.toString(), name: "register data");
//         streamSocket.addResponse(data);
//       });
//       yield* streamSocket.getResponse;
//     } catch (e) {
//       log(e.toString(), name: "getRegister");
//     }
//   }

//   static Stream<String> getDisconnect() async* {
//     final streamSocket = StreamSocketController<String>();
//     try {
//       socket.disconnect();
//       socket.close();
//       // socket.on('server:disconnect', (_) {
//       //   log('disconnect successfull', name: "getDisconnect");
//       //   streamSocket.addResponse('disconnect successfull');
//       // });
//       socket.onDisconnect((_) {
//         streamSocket.addResponse('disconnect successfull');
//       });
//       yield* streamSocket.getResponse;
//     } catch (e) {
//       log(e.toString(), name: "getDisconnect");
//     }
//   }
// }

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

  IO.Socket? socketDisconnected() {
    if (!_socket.disconnected) {
      _socket.disconnect();
      SocketAPI._socketApi = null;
    }
    return _socket;
  }

  void socketRegister(String uid) {
    if (_socket.connected) {
      print("registering");
      _socket.emit('register', {'uid': uid});
    }
  }
}
