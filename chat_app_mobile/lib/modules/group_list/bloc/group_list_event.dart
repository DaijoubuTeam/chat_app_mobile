part of 'group_list_bloc.dart';

abstract class GroupListEvent extends Equatable {
  const GroupListEvent();

  @override
  List<Object?> get props => [];
}

class GroupListInited extends GroupListEvent {}

class GroupListRefreshed extends GroupListEvent {}

class GroupListGroupDeleted extends GroupListEvent {
  const GroupListGroupDeleted({required this.idChatRoom});

  final String idChatRoom;

  @override
  List<Object?> get props => [idChatRoom];
}

class GroupListGroupLeft extends GroupListEvent {
  const GroupListGroupLeft({required this.idChatRoom});

  final String idChatRoom;

  @override
  List<Object?> get props => [idChatRoom];
}
