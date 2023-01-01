part of 'group_member_bloc.dart';

enum DeleteStatus { initial, loading, success, failure }

class GroupMemberState extends Equatable {
  const GroupMemberState({
    this.members,
    this.groupName,
    required this.chatRoomId,
    this.status = FormzStatus.pure,
    this.deleteStatus = DeleteStatus.initial,
    this.isAdmin = false,
    this.displayMembers,
  });

  final List<chat_room_repo.User>? members;
  final List<chat_room_repo.User>? displayMembers;
  final String? groupName;
  final String chatRoomId;
  final bool isAdmin;
  final FormzStatus status;
  final DeleteStatus deleteStatus;

  GroupMemberState copyWith({
    List<chat_room_repo.User>? members,
    List<chat_room_repo.User>? displayMembers,
    String? groupName,
    String? chatRoomId,
    FormzStatus? status,
    DeleteStatus? deleteStatus,
    bool? isAdmin,
  }) {
    return GroupMemberState(
      members: members ?? this.members,
      displayMembers: displayMembers ?? this.displayMembers,
      groupName: groupName ?? this.groupName,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [
        members,
        groupName,
        chatRoomId,
        status,
        deleteStatus,
        isAdmin,
        displayMembers,
      ];
}
