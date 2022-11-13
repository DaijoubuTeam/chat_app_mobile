part of 'chat_room_detail_bloc.dart';

abstract class ChatRoomDetailState extends Equatable {
  const ChatRoomDetailState({required this.chatRoomId});

  final String chatRoomId;
  @override
  List<Object?> get props => [chatRoomId];
}

class ChatRoomDetailInitial extends ChatRoomDetailState {
  const ChatRoomDetailInitial({required super.chatRoomId});
}

class ChatRoomDetailGetDataInProgress extends ChatRoomDetailState {
  const ChatRoomDetailGetDataInProgress({
    required super.chatRoomId,
  });
}

class ChatRoomDetailGetDataSuccess extends ChatRoomDetailState {
  const ChatRoomDetailGetDataSuccess(
      {required super.chatRoomId, this.chatRoomInformation});
  final chat_room_repository.ChatRoom? chatRoomInformation;
}

class ChatRoomDetailGetDataFailure extends ChatRoomDetailState {
  const ChatRoomDetailGetDataFailure({
    required super.chatRoomId,
  });
}


// class ChatRoomDetailState extends ChatRoomDetailState {
//   const ChatRoomDetailInitial({
//     this.chatRoomId,
//     this.avatar,
//     this.fullname,
//     this.email,
//   });

//   final String? chatRoomId;
//   final String? avatar;
//   final String? fullname;
//   final String? email;

//   ChatRoomDetailInitial copyWith({
//     String? avatar,
//     String? fullname,
//     String? email,
//   }) {
//     return ChatRoomDetailInitial(
//       avatar: avatar ?? this.avatar,
//       fullname: fullname ?? this.fullname,
//       email: email ?? this.email,
//     );
//   }

//   @override
//   List<Object?> get props => [avatar, fullname, email];
// }
