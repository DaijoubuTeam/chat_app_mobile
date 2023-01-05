part of 'group_list_bloc.dart';

class GroupListState extends Equatable {
  const GroupListState({
    this.listChatRoom,
    this.status = FormzStatus.pure,
    this.numberRequestRoom = 0,
    this.numberSentRoom = 0,
  });

  final int numberRequestRoom;
  final int numberSentRoom;
  final List<chat_room_repository.ChatRoom>? listChatRoom;
  final FormzStatus status;

  GroupListState copyWith({
    List<chat_room_repository.ChatRoom>? listChatRoom,
    FormzStatus? status,
    int? numberRequestRoom,
    int? numberSentRoom,
  }) {
    return GroupListState(
      listChatRoom: listChatRoom ?? this.listChatRoom,
      status: status ?? this.status,
      numberRequestRoom: numberRequestRoom ?? this.numberRequestRoom,
      numberSentRoom: numberSentRoom ?? this.numberSentRoom,
    );
  }

  @override
  List<Object?> get props => [listChatRoom, status];
}
