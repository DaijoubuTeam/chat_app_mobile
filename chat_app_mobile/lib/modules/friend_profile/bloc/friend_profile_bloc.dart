import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_repository/src/models/user.dart' as user_adapter;

part 'friend_profile_event.dart';
part 'friend_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  FriendProfileBloc() : super(const FriendProfileState()) {
    on<FriendProfilePageInited>(_friendProfilePageInited);
    add(FriendProfilePageInited());
  }

  Future<void> _friendProfilePageInited(
      FriendProfilePageInited event, Emitter<FriendProfileState> emit) async {
    final userBox = await Hive.openBox<user_adapter.User>('user-search-hive');
    final userAdapter = userBox.get("user");
    if (userAdapter != null) {
      emit(
        state.copyWith(
            uid: userAdapter.uid,
            email: userAdapter.email,
            fullname: userAdapter.fullname,
            phone: userAdapter.phone,
            about: userAdapter.about,
            avatar: userAdapter.avatar),
      );
    }
  }
}
