import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketChannelRepository {
  WebSocketChannelRepository({required this.socket});

  IO.Socket socket;
}
