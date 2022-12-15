part of 'group_request_sent_bloc.dart';

abstract class GroupRequestSentState extends Equatable {
  const GroupRequestSentState();
  @override
  List<Object?> get props => [];
}

class GroupRequestSentInitial extends GroupRequestSentState {}

class GroupRequestSentLoading extends GroupRequestSentState {}

class GroupRequestSentFailure extends GroupRequestSentState {}

class GroupRequestGetListSentSuccess extends GroupRequestSentState {
  const GroupRequestGetListSentSuccess({
    required this.listGroupRequestSent,
  });

  final List<chat_room_repo.ChatRoom> listGroupRequestSent;

  // GroupRequestGetListSentSuccess copyWith({
  //   List<chat_room_repo.ChatRoom>? listGroupRequestReceived,
  // }) {
  //   return GroupRequestGetListSentSuccess(
  //     listGroupRequestReceived:
  //         listGroupRequestReceived ?? this.listGroupRequestReceived,
  //   );
  // }

  @override
  List<Object?> get props => [listGroupRequestSent];
}
