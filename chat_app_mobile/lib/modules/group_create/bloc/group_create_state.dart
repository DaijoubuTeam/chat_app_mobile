part of 'group_create_bloc.dart';

class GroupCreateState extends Equatable {
  const GroupCreateState({
    this.groupName,
    this.groupAvatar,
    this.listFriend,
    this.listFriendDisplay,
    this.memberNewGroup,
    this.status = FormzStatus.pure,
  });

  final String? groupName;
  final String? groupAvatar;
  final List<friend_repository.User>? listFriend;
  final List<friend_repository.User>? listFriendDisplay;
  final List<friend_repository.User>? memberNewGroup;
  final FormzStatus status;

  GroupCreateState copyWith({
    String? groupName,
    String? groupAvatar,
    List<friend_repository.User>? listFriend,
    List<friend_repository.User>? listFriendDisplay,
    List<friend_repository.User>? memberNewGroup,
    FormzStatus? status,
  }) {
    return GroupCreateState(
      groupName: groupName ?? this.groupName,
      groupAvatar: groupAvatar ?? this.groupAvatar,
      listFriend: listFriend ?? this.listFriend,
      listFriendDisplay: listFriendDisplay ?? this.listFriendDisplay,
      memberNewGroup: memberNewGroup ?? this.memberNewGroup,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        groupName,
        groupAvatar,
        listFriend,
        listFriendDisplay,
        memberNewGroup,
        status
      ];
}
