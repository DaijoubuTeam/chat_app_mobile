import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketChannelRepository {
  WebSocketChannelRepository({required this.socket});

  IO.Socket socket;

  // Stream<CustomEvent> get customEvent => channel.stream.map(
  //       (event) {
  //         if (event["register"] == "register") {
  //           return RegisterEvent();
  //         }
  //         return RegisterEvent();
  //       },
  //     );
}
