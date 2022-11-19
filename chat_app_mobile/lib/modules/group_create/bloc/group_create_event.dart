part of 'group_create_bloc.dart';

abstract class GroupCreateEvent extends Equatable {
  const GroupCreateEvent();
}

class GroupCreateInited extends GroupCreateEvent {
  @override
  List<Object?> get props => [];
}

class GroupCreateInputChanged extends GroupCreateEvent {
  const GroupCreateInputChanged({this.value});
  final String? value;

  @override
  List<Object?> get props => [value];
}

class GroupCreateMemberChanged extends GroupCreateEvent {
  const GroupCreateMemberChanged({required this.user});
  final friend_repository.User user;

  @override
  List<Object?> get props => [user];
}
