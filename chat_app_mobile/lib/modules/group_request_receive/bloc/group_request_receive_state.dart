part of 'group_request_receive_bloc.dart';

class GroupRequestReceiveState extends Equatable {
  const GroupRequestReceiveState({
    this.listGroupRequestReceived,
    this.status = FormzStatus.pure,
  });

  final List<chat_room_repo.ChatRoom>? listGroupRequestReceived;
  final FormzStatus status;

  GroupRequestReceiveState copyWith({
    List<chat_room_repo.ChatRoom>? listGroupRequestReceived,
    FormzStatus? status,
  }) {
    return GroupRequestReceiveState(
      listGroupRequestReceived:
          listGroupRequestReceived ?? this.listGroupRequestReceived,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [listGroupRequestReceived, status];
}
