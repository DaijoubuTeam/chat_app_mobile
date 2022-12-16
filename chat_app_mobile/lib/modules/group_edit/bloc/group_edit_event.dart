part of 'group_edit_bloc.dart';

abstract class GroupEditEvent extends Equatable {
  const GroupEditEvent();

  @override
  List<Object?> get props => [];
}

class GroupEditInited extends GroupEditEvent {}

class GroupEditSubmitted extends GroupEditEvent {
  const GroupEditSubmitted({this.groupName, this.groupAvatar});

  final String? groupName;
  final String? groupAvatar;

  @override
  List<Object?> get props => [groupName, groupAvatar];
}
