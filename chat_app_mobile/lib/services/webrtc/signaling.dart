import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signaling {
  static final Signaling _signaling = Signaling._internal();

  factory Signaling() {
    return _signaling;
  }

  Signaling._internal();
}
