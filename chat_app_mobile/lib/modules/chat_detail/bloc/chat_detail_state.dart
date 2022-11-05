part of 'chat_detail_bloc.dart';

class ChatDetailState extends Equatable {
  const ChatDetailState({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
  });

  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;

  @override
  List<Object?> get props => [chatRoomId, chatRoomName, chatRoomAvatar];
}
