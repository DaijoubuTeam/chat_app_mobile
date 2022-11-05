part of 'observer_socket_bloc.dart';

abstract class ObserverSocketState extends Equatable {
  const ObserverSocketState();

  @override
  List<Object?> get props => [];
}

class ObserverSocketInitial extends ObserverSocketState {}
