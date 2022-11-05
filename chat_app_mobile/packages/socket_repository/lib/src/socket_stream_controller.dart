import 'dart:async';
import 'dart:developer';

class StreamSocketController<T> {
  StreamSocketController() {
    log('Init Stream controller ${T.toString()}');
  }

  final _socketResponse = StreamController<T>();

  void Function(T) get addResponse => _socketResponse.sink.add;

  Stream<T> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
