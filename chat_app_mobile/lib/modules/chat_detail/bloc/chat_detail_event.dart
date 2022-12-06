part of 'chat_detail_bloc.dart';

abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();

  @override
  List<Object?> get props => [];
}

class ChatDetailPageInited extends ChatDetailEvent {}

class ChatDetailContentChanging extends ChatDetailEvent {
  const ChatDetailContentChanging({this.content, required this.type});

  final String? content;
  final String type;

  @override
  List<Object?> get props => [content, type];
}

class ChatDetailContentSubmitted extends ChatDetailEvent {}

class ChatDetailSpecificSubmitted extends ChatDetailEvent {
  const ChatDetailSpecificSubmitted({this.content, this.type});
  final String? content;
  final String? type;

  @override
  List<Object?> get props => [content, type];
}

class ChatDetailListMessageLoadMore extends ChatDetailEvent {}
