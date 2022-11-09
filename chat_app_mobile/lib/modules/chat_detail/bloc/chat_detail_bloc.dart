import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc({
    required String chatRoomId,
    String? chatRoomName,
    String? chatRoomAvatar,
  }) : super(ChatDetailState(
          chatRoomId: chatRoomId,
          chatRoomName: chatRoomName,
          chatRoomAvatar: chatRoomAvatar,
        )) {}
}
