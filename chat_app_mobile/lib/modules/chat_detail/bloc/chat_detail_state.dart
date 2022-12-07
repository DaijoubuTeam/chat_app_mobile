part of 'chat_detail_bloc.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState({
    required this.chatRoomId,
    this.chatRoomInfo,
    this.listMessage,
    this.displayListMessage,
    this.latestMessage,
    this.content,
    this.startMessageIndex = 20,
    this.endMessageIndex = 20,
    this.type = "text",
    this.status = FormzStatus.pure,
  });

  final String chatRoomId;
  final chat_room_repository.ChatRoom? chatRoomInfo;
  final List<message_repository.Message>? listMessage;
  final List<message_repository.Message>? displayListMessage;
  final chat_room_repository.Message? latestMessage;
  final int startMessageIndex;
  final int endMessageIndex;
  final String? content;
  final String type;
  final FormzStatus status;

  ChatDetailState copyWith({
    chat_room_repository.ChatRoom? chatRoomInfo,
    List<message_repository.Message>? listMessage,
    List<message_repository.Message>? displayListMessage,
    chat_room_repository.Message? latestMessage,
    String? content,
    int? startMessageIndex,
    int? endMessageIndex,
    FormzStatus? status,
    String? type,
  }) {
    return ChatDetailState(
      chatRoomId: chatRoomId,
      chatRoomInfo: chatRoomInfo ?? this.chatRoomInfo,
      content: content ?? this.content,
      type: type ?? this.type,
      listMessage: listMessage ?? this.listMessage,
      displayListMessage: displayListMessage ?? this.displayListMessage,
      latestMessage: latestMessage ?? this.latestMessage,
      startMessageIndex: startMessageIndex ?? this.startMessageIndex,
      endMessageIndex: endMessageIndex ?? this.endMessageIndex,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        chatRoomId,
        chatRoomInfo,
        status,
        listMessage,
        displayListMessage,
        latestMessage,
        startMessageIndex,
        endMessageIndex,
        content,
        type
      ];
}
