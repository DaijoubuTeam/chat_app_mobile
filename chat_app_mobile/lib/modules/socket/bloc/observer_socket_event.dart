part of 'observer_socket_bloc.dart';

abstract class ObserverSocketEvent extends Equatable {
  const ObserverSocketEvent();

  @override
  List<Object?> get props => [];
}

class ObserverSocketInited extends ObserverSocketEvent {}

class ObserverSocketMessageSent extends ObserverSocketEvent {
  const ObserverSocketMessageSent({
    required this.chatRoomId,
    required this.from,
    required this.content,
  });

  final String chatRoomId;
  final String from;
  final String content;

  @override
  List<Object?> get props => [chatRoomId, from, content];
}
