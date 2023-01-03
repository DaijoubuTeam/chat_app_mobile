part of 'chat_detail_bloc.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState({
    required this.chatRoomId,
    this.chatRoomInfo,
    this.listMessage,
    this.latestMessage,
    this.content,
    this.startMessageIndex = 20,
    this.endMessageIndex = 20,
    this.type = "text",
    this.status = FormzStatus.pure,
    this.isShowEmoji = false,
    this.isShowSend = false,
    this.isShowSticker = false,
    this.isLoading = false,
    this.isUploadLargeFile = false,
  });

  final String chatRoomId;
  final chat_room_repository.ChatRoom? chatRoomInfo;
  final List<message_repository.Message>? listMessage;
  final chat_room_repository.Message? latestMessage;
  final int startMessageIndex;
  final int endMessageIndex;
  final String? content;
  final String type;
  final FormzStatus status;
  //show options in chat box
  final bool isShowEmoji;
  final bool isShowSticker;
  final bool isShowSend;
  final bool isLoading;
  final bool isUploadLargeFile;

  ChatDetailState copyWith({
    chat_room_repository.ChatRoom? chatRoomInfo,
    List<message_repository.Message>? listMessage,
    List<message_repository.Message>? displayListMessage,
    chat_room_repository.Message? latestMessage,
    List<chat_room_repository.User>? friends,
    String? content,
    int? startMessageIndex,
    int? endMessageIndex,
    FormzStatus? status,
    String? type,
    bool? isShowEmoji,
    bool? isShowSticker,
    bool? isShowSend,
    bool? isLoading,
    bool? isUploadLargeFile,
  }) {
    return ChatDetailState(
      chatRoomId: chatRoomId,
      chatRoomInfo: chatRoomInfo ?? this.chatRoomInfo,
      content: content ?? this.content,
      type: type ?? this.type,
      listMessage: listMessage ?? this.listMessage,
      latestMessage: latestMessage ?? this.latestMessage,
      startMessageIndex: startMessageIndex ?? this.startMessageIndex,
      endMessageIndex: endMessageIndex ?? this.endMessageIndex,
      status: status ?? this.status,
      isShowEmoji: isShowEmoji ?? this.isShowEmoji,
      isShowSticker: isShowSticker ?? this.isShowSticker,
      isShowSend: isShowSend ?? this.isShowSend,
      isLoading: isLoading ?? this.isLoading,
      isUploadLargeFile: isUploadLargeFile ?? this.isUploadLargeFile,
    );
  }

  @override
  List<Object?> get props => [
        chatRoomId,
        chatRoomInfo,
        status,
        listMessage,
        latestMessage,
        startMessageIndex,
        endMessageIndex,
        content,
        type,
        isShowEmoji,
        isShowSticker,
        isShowSend,
        isLoading,
        isUploadLargeFile,
      ];
}
