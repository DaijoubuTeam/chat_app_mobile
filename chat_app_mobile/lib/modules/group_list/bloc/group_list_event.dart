part of 'group_list_bloc.dart';

abstract class GroupListEvent extends Equatable {
  const GroupListEvent();
}

class GroupListInited extends GroupListEvent {
  @override
  List<Object?> get props => [];
}

class GroupListGroupDeleted extends GroupListEvent {
  const GroupListGroupDeleted({required this.idChatRoom});

  final String idChatRoom;

  @override
  List<Object?> get props => [idChatRoom];
}
