import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

part 'group_edit_event.dart';
part 'group_edit_state.dart';

class GroupEditBloc extends Bloc<GroupEditEvent, GroupEditState> {
  GroupEditBloc({
    required String groupId,
    required auth_repository.AuthRepository authRepository,
    required chat_room_repo.ChatRoomRepository chatRoomRepository,
  })  : _authRepository = authRepository,
        _chatRoomRepository = chatRoomRepository,
        _groupId = groupId,
        super(GroupEditInitial(groupId: groupId)) {
    on<GroupEditInited>(_onGroupInited);
    on<GroupEditInputChanged>(_onGroupEditInputChanged);
    on<GroupEditAvatarChanged>(_onGroupEditAvatarChanged);
    on<GroupEditSubmitted>(_onGroupEditSubmitted);
    add(GroupEditInited());
  }

  final String _groupId;
  final auth_repository.AuthRepository _authRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupInited(
      GroupEditInited event, Emitter<GroupEditState> emit) async {
    try {
      emit(GroupEditInitial(groupId: _groupId));
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final chat_room_repo.ChatRoom groupInfor =
            await _chatRoomRepository.getChatRoomById(
          bearerToken,
          _groupId,
          _authRepository.currentUser.uid,
        );
        emit(GroupEditGetInforSuccess(
          groupId: _groupId,
          groupName: groupInfor.chatRoomName,
          groupAvatar: groupInfor.chatRoomAvatar,
        ));
      }
    } catch (_) {
      emit(GroupEditGetInforFailure(groupId: _groupId));
    }
  }

  void _onGroupEditInputChanged(
      GroupEditInputChanged event, Emitter<GroupEditState> emit) {
    if (event.input != null) {
      if (state is GroupEditGetInforSuccess) {
        final urlImage = (state as GroupEditGetInforSuccess).groupAvatar;
        emit(
          GroupEditGetInforSuccess(
              groupId: state.groupId,
              groupName: event.input,
              groupAvatar: urlImage),
        );
      }
    }
  }

  void _onGroupEditAvatarChanged(
      GroupEditAvatarChanged event, Emitter<GroupEditState> emit) {
    if (event.urlImage != null) {
      if (state is GroupEditGetInforSuccess) {
        final inputName = (state as GroupEditGetInforSuccess).groupName;
        emit(GroupEditGetInforSuccess(
          groupId: state.groupId,
          groupAvatar: event.urlImage,
          groupName: inputName,
        ));
      }
    }
  }

  Future<void> _onGroupEditSubmitted(
      GroupEditSubmitted event, Emitter<GroupEditState> emit) async {
    try {
      if (state is GroupEditGetInforSuccess) {
        final groupName = (state as GroupEditGetInforSuccess).groupName;
        final urlImage = (state as GroupEditGetInforSuccess).groupAvatar;
        if (groupName != null && groupName != "") {
          final bearerToken = await _authRepository.bearToken;
          if (bearerToken != null) {
            final isUpdateSuccess = await _chatRoomRepository.updateChatRoom(
                bearerToken, state.groupId, groupName, urlImage);
            if (isUpdateSuccess) {
              FlutterToastCustom.showToast(
                  "Update group chat success", "success");
            } else {
              FlutterToastCustom.showToast("Update group chat fail", "error");
            }
          }
        } else {
          FlutterToastCustom.showToast(
              "The group name cannot be empty", "warning");
        }
      }
    } catch (err) {
      log(err.toString(), name: "update group infor");
    }
  }
}
