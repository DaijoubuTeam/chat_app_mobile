import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friend_profile_event.dart';
part 'friend_profile_state.dart';

class FriendProfileBloc extends Bloc<FriendProfileEvent, FriendProfileState> {
  FriendProfileBloc() : super(const FriendProfileState()) {
    // on<FriendProfilePageInited>(_friendProfilePageInited);
    // on<FriendProfilePageClose>(_friendProfilePageClose);
    // add(FriendProfilePageInited());
  }

  Future<void> _friendProfilePageInited(
      FriendProfilePageInited event, Emitter<FriendProfileState> emit) async {
    // final userBox = await Hive.openBox<user_adapter.User>('user-search-hive');
    // final userAdapter = userBox.get("user");
    // print(userAdapter);
    // if (userAdapter != null && userBox.length > 0) {
    //   emit(
    //     state.copyWith(
    //         uid: userAdapter.uid,
    //         email: userAdapter.email,
    //         fullname: userAdapter.fullname,
    //         phone: userAdapter.phone,
    //         about: userAdapter.about,
    //         avatar: userAdapter.avatar),
    //   );
    return;
  }

  Future<void> _friendProfilePageClose(
      FriendProfilePageClose event, Emitter<FriendProfileState> emit) async {
    return;
  }
}
