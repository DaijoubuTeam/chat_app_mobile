part of 'group_edit_bloc.dart';

abstract class GroupEditState extends Equatable {
  const GroupEditState({required this.groupId});

  final String groupId;

  @override
  List<Object?> get props => [];
}

class GroupEditInitial extends GroupEditState {
  const GroupEditInitial({
    required String groupId,
  }) : super(groupId: groupId);

  @override
  List<Object?> get props => [groupId];
}

class GroupEditGetInforSuccess extends GroupEditState {
  const GroupEditGetInforSuccess({
    required String groupId,
    this.groupName,
    this.groupAvatar,
  }) : super(groupId: groupId);

  final String? groupName;
  final String? groupAvatar;

  GroupEditState copyWith({
    String? groupName,
    String? groupAvatar,
  }) {
    return GroupEditGetInforSuccess(
      groupId: groupId,
      groupName: groupName ?? this.groupName,
      groupAvatar: groupAvatar ?? this.groupAvatar,
    );
  }

  @override
  List<Object?> get props => [groupId, groupName, groupAvatar];
}

class GroupEditGetInforFailure extends GroupEditState {
  const GroupEditGetInforFailure({
    required String groupId,
  }) : super(groupId: groupId);

  @override
  List<Object?> get props => [groupId];
}
