import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'find_friend_event.dart';
part 'find_friend_state.dart';

class FindFriendBloc extends Bloc<FindFriendEvent, FindFriendState> {
  FindFriendBloc() : super(const FindFriendState()) {
    on<FindFriendInputSearchChanged>(_findFriendInputSearchChanged);
  }

  void _findFriendInputSearchChanged(event, Emitter<FindFriendState> emit) {
    emit(event.textInput.isNotEmpty
        ? state.copyWith(inputSearch: event.textInput)
        : state.copyWith());
  }
}
