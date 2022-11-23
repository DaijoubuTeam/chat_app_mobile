part of 'group_add_new_member_bloc.dart';

class GroupAddNewMemberState extends Equatable {
  const GroupAddNewMemberState({
    required this.chatRoomId,
    required this.currentMembersInGroup,
    this.listFriend,
    this.listFriendDisplay,
    this.newMemberGroup,
    this.status = FormzStatus.pure,
  });

  final String chatRoomId;
  final List<chat_room_repo.User> currentMembersInGroup;
  final List<friend_repository.User>? listFriend;
  final List<friend_repository.User>? listFriendDisplay;
  final List<friend_repository.User>? newMemberGroup;
  final FormzStatus status;

  GroupAddNewMemberState copyWith({
    List<friend_repository.User>? listFriend,
    List<friend_repository.User>? listFriendDisplay,
    List<friend_repository.User>? newMemberGroup,
    FormzStatus? status,
  }) {
    return GroupAddNewMemberState(
      chatRoomId: chatRoomId,
      currentMembersInGroup: currentMembersInGroup,
      listFriend: listFriend ?? this.listFriend,
      listFriendDisplay: listFriendDisplay ?? this.listFriendDisplay,
      newMemberGroup: newMemberGroup ?? this.newMemberGroup,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        chatRoomId,
        currentMembersInGroup,
        listFriend,
        listFriendDisplay,
        newMemberGroup,
        status
      ];
}
