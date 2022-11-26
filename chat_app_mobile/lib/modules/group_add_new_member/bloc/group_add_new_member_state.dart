part of 'group_add_new_member_bloc.dart';

enum ActionStatus { initial, loading, success, failure }

class GroupAddNewMemberState extends Equatable {
  const GroupAddNewMemberState({
    required this.chatRoomId,
    required this.currentMembersInGroup,
    this.listFriend,
    this.listFriendDisplay,
    this.newMemberGroup,
    this.status = FormzStatus.pure,
    this.actionStatus = ActionStatus.initial,
  });

  final String chatRoomId;
  final List<chat_room_repo.User> currentMembersInGroup;
  final List<friend_repository.User>? listFriend;
  final List<friend_repository.User>? listFriendDisplay;
  final List<friend_repository.User>? newMemberGroup;
  final FormzStatus status;
  final ActionStatus actionStatus;

  GroupAddNewMemberState copyWith({
    List<friend_repository.User>? listFriend,
    List<friend_repository.User>? listFriendDisplay,
    List<friend_repository.User>? newMemberGroup,
    FormzStatus? status,
    ActionStatus? actionStatus,
  }) {
    return GroupAddNewMemberState(
      chatRoomId: chatRoomId,
      currentMembersInGroup: currentMembersInGroup,
      listFriend: listFriend ?? this.listFriend,
      listFriendDisplay: listFriendDisplay ?? this.listFriendDisplay,
      newMemberGroup: newMemberGroup ?? this.newMemberGroup,
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
    );
  }

  @override
  List<Object?> get props => [
        chatRoomId,
        currentMembersInGroup,
        listFriend,
        listFriendDisplay,
        newMemberGroup,
        status,
        actionStatus
      ];
}
