import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;
import 'package:auth_repository/auth_repository.dart' as auth_repo;
import 'package:formz/formz.dart';

part 'group_member_event.dart';
part 'group_member_state.dart';

class GroupMemberBloc extends Bloc<GroupMemberEvent, GroupMemberState> {
  GroupMemberBloc(
    chat_room_repo.ChatRoom? chatRoom,
    auth_repo.AuthRepository authRepository,
    chat_room_repo.ChatRoomRepository chatRoomRepository,
  )   : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        super(GroupMemberState(
          members: chatRoom?.members.toList(),
          displayMembers: chatRoom?.members.toList(),
          groupName: chatRoom?.chatRoomName,
          chatRoomId: chatRoom!.chatRoomId,
          isAdmin: chatRoom.isAdmin,
        )) {
    on<GroupMemberDeleteSubmitted>(_onGroupMemberDeleteSubmitted);
    on<GroupMemberInputSearchChanged>(_onGroupMemberInputSearchChanged);
  }

  final auth_repo.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  void _onGroupMemberInputSearchChanged(
      GroupMemberInputSearchChanged event, Emitter<GroupMemberState> emit) {
    final listMemberDisplay = state.members
        ?.where((friend) =>
            (friend.fullname!.toLowerCase().contains(event.value.toString()) ||
                friend.email!.toLowerCase().contains(event.value.toString())))
        .toList();
    emit(state.copyWith(displayMembers: listMemberDisplay));
  }

  Future<void> _onGroupMemberDeleteSubmitted(
      GroupMemberDeleteSubmitted event, Emitter<GroupMemberState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _chatRoomRepository.removeMemberChatRoom(
          bearerToken,
          state.chatRoomId,
          event.idMember,
        );

        if (res) {
          final List<chat_room_repo.User> newListMemberDisplay = state.members!
              .where((member) => member.uid != event.idMember)
              .toList();
          FlutterToastCustom.showToast("Delete member success", "success");
          emit(
            state.copyWith(
              members: newListMemberDisplay,
              displayMembers: newListMemberDisplay,
            ),
          );
        } else {
          FlutterToastCustom.showToast(
              "Delete member fail! Try again", "error");
        }
      }
    } catch (e) {
      FlutterToastCustom.showToast(e.toString(), "error");
    }
  }
}
