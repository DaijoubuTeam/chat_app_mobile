part of 'group_member_bloc.dart';

abstract class GroupMemberEvent extends Equatable {
  const GroupMemberEvent();
}

class GroupMemberInited extends GroupMemberEvent {
  @override
  List<Object?> get props => [];
}

class GroupMemberInputSearchChanged extends GroupMemberEvent {
  const GroupMemberInputSearchChanged({this.value});

  final String? value;

  @override
  List<Object?> get props => [value];
}

class GroupMemberDeleteSubmitted extends GroupMemberEvent {
  const GroupMemberDeleteSubmitted({required this.idMember});

  final String idMember;

  @override
  List<Object?> get props => [idMember];
}
