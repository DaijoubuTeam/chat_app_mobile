import 'package:web_socket_channel/io.dart';

import 'package:web_socket_repository/src/events/register_event.dart';

import 'events/custom_event.dart';

class WebSocketChannelRepository {
  WebSocketChannelRepository({required this.url})
      : _channel = IOWebSocketChannel.connect(Uri.parse(url));

  final String url;
  IOWebSocketChannel _channel;

  Stream<CustomEvent> get customEvent => _channel.stream.map((event) {
        if (event["register"] == "register") {
          return RegisterEvent();
        }
        return RegisterEvent();
      });
}
