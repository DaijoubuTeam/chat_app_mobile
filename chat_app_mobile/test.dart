// import 'dart:html';

// import 'package:web_socket_channel/io.dart';

// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

// main() async {
//   var channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));

//   final chatWebSocket = ChatWebSocket(channel);
//   chatWebSocket.EventStream.listen((event) {
//     if (event.runtimeType == NewMessageEvent) {
//       print('new message');
//     } else {
//       print('unknown event');
//     }
//   });
// }

// abstract class CustomEvent {}

// class NewMessageEvent extends CustomEvent {}

// class UnknownEvent extends CustomEvent {}

// class ChatWebSocket {
//   final IOWebSocketChannel channel;
//   ChatWebSocket(this.channel);

//   Stream<CustomEvent> get EventStream => channel.stream.map((event) {
//         if (event['event'] == "new-message") {
//           return NewMessageEvent();
//         }
//         return UnknownEvent();
//       });
// }
