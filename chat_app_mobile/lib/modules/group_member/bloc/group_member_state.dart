part of 'group_member_bloc.dart';

class GroupMemberState extends Equatable {
  const GroupMemberState({
    this.members,
    this.groupName,
    required this.chatRoomId,
    this.status = FormzStatus.pure,
    this.isAdmin = false,
    this.displayMembers,
  });

  final List<chat_room_repo.User>? members;
  final List<chat_room_repo.User>? displayMembers;
  final String? groupName;
  final String chatRoomId;
  final bool isAdmin;
  final FormzStatus status;

  GroupMemberState copyWith({
    List<chat_room_repo.User>? members,
    List<chat_room_repo.User>? displayMembers,
    String? groupName,
    String? chatRoomId,
    FormzStatus? status,
    bool? isAdmin,
  }) {
    return GroupMemberState(
      members: members ?? this.members,
      displayMembers: displayMembers ?? this.displayMembers,
      groupName: groupName ?? this.groupName,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [
        members,
        groupName,
        chatRoomId,
        status,
        isAdmin,
        displayMembers,
      ];
}
