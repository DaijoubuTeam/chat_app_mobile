part of 'group_add_new_member_bloc.dart';

abstract class GroupAddNewMemberEvent extends Equatable {
  const GroupAddNewMemberEvent();

  @override
  List<Object?> get props => [];
}

class GroupAddNewMemberInputInitialized extends GroupAddNewMemberEvent {}

class GroupAddNewMemberInputSearchChanged extends GroupAddNewMemberEvent {
  const GroupAddNewMemberInputSearchChanged({this.value});

  final String? value;

  @override
  List<Object?> get props => [value];
}

class GroupOptionsNewMemberChanged extends GroupAddNewMemberEvent {
  const GroupOptionsNewMemberChanged({required this.user});

  final friend_repository.User user;

  @override
  List<Object?> get props => [user];
}

class GroupAddNewMemberButtonSubmitted extends GroupAddNewMemberEvent {}
