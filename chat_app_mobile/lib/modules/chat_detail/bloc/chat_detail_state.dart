part of 'chat_detail_bloc.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
    this.listMessage,
    this.content,
    this.status = FormzStatus.pure,
  });

  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;
  final List<chat_message_repo.ChatMessage>? listMessage;
  final String? content;
  final FormzStatus status;

  ChatDetailState copyWith({
    String? content,
    List<chat_message_repo.ChatMessage>? listMessage,
    FormzStatus? status,
  }) {
    return ChatDetailState(
        chatRoomId: chatRoomId,
        content: content ?? this.content,
        listMessage: listMessage ?? this.listMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [chatRoomId, chatRoomName, chatRoomAvatar, listMessage, content];
}
