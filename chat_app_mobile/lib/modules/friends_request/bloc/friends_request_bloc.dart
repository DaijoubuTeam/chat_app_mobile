import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friends_request_event.dart';
part 'friends_request_state.dart';

class FriendsRequestBloc
    extends Bloc<FriendsRequestEvent, FriendsRequestState> {
  FriendsRequestBloc() : super(const FriendsRequestState()) {
    on<FriendRequestInputSearchChanged>(_friendRequestInputSearchChanged);
  }

  void _friendRequestInputSearchChanged(FriendRequestInputSearchChanged event,
      Emitter<FriendsRequestState> emit) {
    emit(event.textInput.isNotEmpty
        ? state.copyWith(inputSearch: event.textInput)
        : state.copyWith());
  }
}
