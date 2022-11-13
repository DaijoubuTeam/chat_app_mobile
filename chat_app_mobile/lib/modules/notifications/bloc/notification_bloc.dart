import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notification_repository/notification_repository.dart'
    as notification_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:friend_repository/friend_repository.dart' as friend_repository;

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required auth_repository.AuthRepository authRepository,
    required notification_repository.NotificationRepository
        notificationRepository,
    required friend_repository.FriendRepository friendRepository,
  })  : _authRepository = authRepository,
        _notificationRepository = notificationRepository,
        _friendRepository = friendRepository,
        super(NotificationInitial()) {
    on<NotificationInited>(_onNotificationInited);
    on<NotificationRequestSubmitted>(_onNotificationRequestSubmitted);

    add(NotificationInited());
  }

  final notification_repository.NotificationRepository _notificationRepository;

  final auth_repository.AuthRepository _authRepository;

  final friend_repository.FriendRepository _friendRepository;

  Future<void> _onNotificationInited(
      NotificationInited event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationGetListInProgress());
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listNotification =
            await _notificationRepository.getUserNotification(bearerToken);
        emit(NotificationGetListSuccess(listNotification: listNotification));
      }
    } catch (err) {
      emit(NotificationGetListFailure());
    }
  }

  Future<void> _onNotificationRequestSubmitted(
      NotificationRequestSubmitted event,
      Emitter<NotificationState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final res = await _friendRepository.actionWithFriend(
          bearerToken,
          event.idSender,
          event.typeAction,
        );
        if (res) {
          add(NotificationInited());
        }
      }
    } catch (err) {
      emit(NotificationGetListFailure());
    }
  }
}
