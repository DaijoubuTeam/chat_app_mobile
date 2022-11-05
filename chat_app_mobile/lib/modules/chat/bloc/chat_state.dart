part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatGetListRequest extends ChatState {}

class ChatGetListSuccess extends ChatState {
  const ChatGetListSuccess({required this.listChatRoom});

  final List<chat_room_repository.ChatRoom> listChatRoom;

  @override
  List<Object> get props => [listChatRoom];
}

class ChatGetListFailure extends ChatState {}
