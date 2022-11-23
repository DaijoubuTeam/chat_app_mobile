part of 'group_member_bloc.dart';

abstract class GroupMemberEvent extends Equatable {
  const GroupMemberEvent();
}

class GroupMemberInited extends GroupMemberEvent {
  @override
  List<Object?> get props => [];
}

class GroupMemberDeleteSubmitted extends GroupMemberEvent {
  const GroupMemberDeleteSubmitted({required this.idMember});

  final String idMember;

  @override
  List<Object?> get props => [idMember];
}
