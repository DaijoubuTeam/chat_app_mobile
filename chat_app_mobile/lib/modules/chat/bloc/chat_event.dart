part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatPageInited extends ChatEvent {}

class ChatPageRefreshed extends ChatEvent {}
