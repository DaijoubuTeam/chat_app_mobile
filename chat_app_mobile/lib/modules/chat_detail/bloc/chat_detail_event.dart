part of 'chat_detail_bloc.dart';

abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();

  @override
  List<Object?> get props => [];
}

class ChatDetailPageInited extends ChatDetailEvent {}

class ChatDetailContentChanging extends ChatDetailEvent {
  const ChatDetailContentChanging(this.content);

  final String? content;

  @override
  List<Object?> get props => [];
}

class ChatDetailContentSubmitted extends ChatDetailEvent {}
