import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

part 'group_create_event.dart';
part 'group_create_state.dart';

class GroupCreateBloc extends Bloc<GroupCreateEvent, GroupCreateState> {
  GroupCreateBloc(
    this._authRepository,
    this._friendRepository,
    this._chatRoomRepository,
  ) : super(const GroupCreateState()) {
    on<GroupCreateInited>(_onGroupCreateInited);
    on<GroupCreateAvatarImageChanged>(_onGroupCreateAvatarImageChanged);
    on<GroupCreateNameInputChanged>(_onGroupCreateNameInputChanged);
    on<GroupCreateInputChanged>(_onGroupCreateInputChanged);
    on<GroupCreateMemberChanged>(_onGroupCreateMemberChanged);
    on<GroupCreateFormSubmitted>(_onGroupCreateFormSubmitted);

    add(GroupCreateInited());
  }

  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;
  final chat_room_repo.ChatRoomRepository _chatRoomRepository;

  Future<void> _onGroupCreateInited(
      GroupCreateInited event, Emitter<GroupCreateState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listFriend =
            await _friendRepository.getListUserFriends(bearerToken);
        emit(state.copyWith(
          listFriend: listFriend,
          listFriendDisplay: listFriend,
          memberNewGroup: [],
          status: FormzStatus.submissionSuccess,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onGroupCreateAvatarImageChanged(
      GroupCreateAvatarImageChanged event, Emitter<GroupCreateState> emit) {
    if (event.urlImage == null) return;
    emit(
      state.copyWith(
        groupAvatar: event.urlImage!,
      ),
    );
  }

  void _onGroupCreateNameInputChanged(event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(groupName: event.value));
  }

  void _onGroupCreateInputChanged(
      GroupCreateInputChanged event, Emitter<GroupCreateState> emit) {
    final listFriendDisplay = state.listFriend
        ?.where(
          (friend) =>
              friend.fullname!.toLowerCase().contains(event.value.toString()) ||
              friend.email!.toLowerCase().contains(event.value.toString()),
        )
        .toList();
    emit(state.copyWith(listFriendDisplay: listFriendDisplay));
  }

  void _onGroupCreateMemberChanged(
      GroupCreateMemberChanged event, Emitter<GroupCreateState> emit) {
    if (state.memberNewGroup == null) return;
    final List<friend_repository.User> listNewMember =
        List.from(state.memberNewGroup!);
    if (state.memberNewGroup!.contains(event.user)) {
      listNewMember.remove(event.user);
    } else {
      listNewMember.add(event.user);
    }
    emit(state.copyWith(memberNewGroup: listNewMember));
  }

  Future<void> _onGroupCreateFormSubmitted(
      GroupCreateFormSubmitted event, Emitter<GroupCreateState> emit) async {
    try {
      if (state.groupName == null || state.groupName == '') {
        FlutterToastCustom.showToast("Group name cannot be empty", "warning");
        return;
      }
      List<String>? listIdMembers = [];
      if (state.memberNewGroup != null) {
        listIdMembers =
            state.memberNewGroup?.map((member) => member.uid).toList();
      }

      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null) {
        final isCreateRoomSuccess = await _chatRoomRepository.createNewChatRoom(
          bearerToken,
          state.groupName!,
          state.groupAvatar,
          listIdMembers,
        );
        if (isCreateRoomSuccess) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
          FlutterToastCustom.showToast("Create group success", "success");
          return;
        }
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      FlutterToastCustom.showToast("Group creation failed", "error");
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
