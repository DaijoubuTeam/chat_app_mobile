part of 'observer_socket_bloc.dart';

abstract class ObserverSocketEvent extends Equatable {
  const ObserverSocketEvent();

  @override
  List<Object?> get props => [];
}

class ObserverSocketInited extends ObserverSocketEvent {}
