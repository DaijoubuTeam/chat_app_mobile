part of 'group_member_bloc.dart';

class GroupMemberState extends Equatable {
  const GroupMemberState({
    this.members,
    this.groupName,
    required this.chatRoomId,
    this.status = FormzStatus.pure,
  });

  final List<chat_room_repo.User>? members;
  final String? groupName;
  final String chatRoomId;
  final FormzStatus status;

  GroupMemberState copyWith({
    List<chat_room_repo.User>? members,
    String? groupName,
    String? chatRoomId,
    FormzStatus? status,
  }) {
    return GroupMemberState(
      members: members ?? this.members,
      groupName: groupName ?? this.groupName,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [members, groupName, chatRoomId, status];
}
