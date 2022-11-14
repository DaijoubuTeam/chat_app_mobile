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
  final List<message_repository.Message>? listMessage;
  final String? content;
  final FormzStatus status;

  ChatDetailState copyWith({
    String? content,
    List<message_repository.Message>? listMessage,
    FormzStatus? status,
    String? chatRoomName,
    String? chatRoomAvatar,
  }) {
    return ChatDetailState(
        chatRoomId: chatRoomId,
        chatRoomName: chatRoomName ?? this.chatRoomName,
        chatRoomAvatar: chatRoomAvatar ?? this.chatRoomAvatar,
        content: content ?? this.content,
        listMessage: listMessage ?? this.listMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [chatRoomId, chatRoomName, chatRoomAvatar, status, listMessage, content];
}