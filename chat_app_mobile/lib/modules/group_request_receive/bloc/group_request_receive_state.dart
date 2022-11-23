part of 'group_request_receive_bloc.dart';

enum ActionSubmitState {
  submitInitial,
  submitSuccess,
  submitFailure,
  submitLoading
}

class GroupRequestReceiveState extends Equatable {
  const GroupRequestReceiveState(
      {this.listGroupRequestReceived,
      this.status = FormzStatus.pure,
      this.actionSubmitStatus = ActionSubmitState.submitInitial});

  final List<chat_room_repo.ChatRoom>? listGroupRequestReceived;
  final FormzStatus status;
  final ActionSubmitState actionSubmitStatus;

  GroupRequestReceiveState copyWith(
      {List<chat_room_repo.ChatRoom>? listGroupRequestReceived,
      FormzStatus? status,
      ActionSubmitState? actionSubmitStatus}) {
    return GroupRequestReceiveState(
      listGroupRequestReceived:
          listGroupRequestReceived ?? this.listGroupRequestReceived,
      status: status ?? this.status,
      actionSubmitStatus: actionSubmitStatus ?? this.actionSubmitStatus,
    );
  }

  @override
  List<Object?> get props =>
      [listGroupRequestReceived, status, actionSubmitStatus];
}
