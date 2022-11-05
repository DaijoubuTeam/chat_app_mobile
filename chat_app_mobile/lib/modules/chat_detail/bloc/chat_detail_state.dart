part of 'chat_detail_bloc.dart';

abstract class ChatDetailState extends Equatable {
  const ChatDetailState();

  @override
  List<Object?> get props => [];
}

class ChatDetailInitial extends ChatDetailState {
  const ChatDetailInitial({
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
  });

  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;

  @override
  List<Object?> get props => [chatRoomId];
}
