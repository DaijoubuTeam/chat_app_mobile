part of 'chat_room_detail_bloc.dart';

abstract class ChatRoomDetailEvent extends Equatable {
  const ChatRoomDetailEvent();

  @override
  List<Object?> get props => [];
}

class ChatRoomDetailInited extends ChatRoomDetailEvent {}

class ChatRoomDetailNotificationChanged extends ChatRoomDetailEvent {}

class ChatRoomDetailFriendDeleted extends ChatRoomDetailEvent {
  const ChatRoomDetailFriendDeleted({required this.friendId});
  final String friendId;

  @override
  List<Object?> get props => [friendId];
}
