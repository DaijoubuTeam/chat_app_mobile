part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class SelectTabIndexChanged extends HomeEvent {
  const SelectTabIndexChanged(this.tabIndex);

  final int tabIndex;

  @override
  List<Object?> get props => [tabIndex];
}

class SelectActionCallReject extends HomeEvent {
  const SelectActionCallReject({required this.friendId});
  final String friendId;

  @override
  List<Object?> get props => [friendId];
}
