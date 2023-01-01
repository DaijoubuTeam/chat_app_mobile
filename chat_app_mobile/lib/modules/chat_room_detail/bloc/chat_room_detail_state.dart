part of 'chat_room_detail_bloc.dart';

abstract class ChatRoomDetailState extends Equatable {
  const ChatRoomDetailState({
    required this.chatRoomId,
  });

  final String chatRoomId;

  @override
  List<Object?> get props => [chatRoomId];
}

class ChatRoomDetailInitial extends ChatRoomDetailState {
  const ChatRoomDetailInitial({
    required super.chatRoomId,
  });
}

class ChatRoomDetailGetDataInProgress extends ChatRoomDetailState {
  const ChatRoomDetailGetDataInProgress({
    required super.chatRoomId,
  });
}

class ChatRoomDetailGetDataSuccess extends ChatRoomDetailState {
  const ChatRoomDetailGetDataSuccess({
    required super.chatRoomId,
    this.chatRoomInformation,
    this.status = FormzStatus.invalid,
  });

  final chat_room_repository.ChatRoom? chatRoomInformation;
  final FormzStatus status;

  ChatRoomDetailGetDataSuccess copyWith({
    chat_room_repository.ChatRoom? chatRoomInformation,
    FormzStatus? status,
  }) {
    return ChatRoomDetailGetDataSuccess(
      chatRoomId: chatRoomId,
      chatRoomInformation: chatRoomInformation ?? this.chatRoomInformation,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [chatRoomId, chatRoomInformation, status];
}

class ChatRoomDetailGetDataFailure extends ChatRoomDetailState {
  const ChatRoomDetailGetDataFailure({
    required super.chatRoomId,
  });
}

class ChatRoomDetailRemoved extends ChatRoomDetailState {
  const ChatRoomDetailRemoved({required super.chatRoomId});
}
