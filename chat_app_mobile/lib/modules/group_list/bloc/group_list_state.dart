part of 'group_list_bloc.dart';

class GroupListState extends Equatable {
  const GroupListState({
    this.listChatRoom,
    this.status = FormzStatus.pure,
  });

  final List<chat_room_repository.ChatRoom>? listChatRoom;
  final FormzStatus status;

  GroupListState copyWith({
    List<chat_room_repository.ChatRoom>? listChatRoom,
    FormzStatus? status,
  }) {
    return GroupListState(
      listChatRoom: listChatRoom ?? this.listChatRoom,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [listChatRoom, status];
}
