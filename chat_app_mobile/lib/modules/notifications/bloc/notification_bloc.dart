import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notification_repository/notification_repository.dart'
    as notification_repository;
import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:friend_repository/friend_repository.dart' as friend_repository;
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repository;
import 'package:socket_repository/socket_repository.dart' as socket_repo;

import '../../../common/widgets/toasts/flutter_toast.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required auth_repository.AuthRepository authRepository,
    required notification_repository.NotificationRepository
        notificationRepository,
    required friend_repository.FriendRepository friendRepository,
    required chat_room_repository.ChatRoomRepository chatRoomRepository,
  })  : _authRepository = authRepository,
        _notificationRepository = notificationRepository,
        _friendRepository = friendRepository,
        _chatRoomRepository = chatRoomRepository,
        super(NotificationInitial()) {
    on<NotificationInited>(_onNotificationInited);
    on<NotificationRequestSubmitted>(_onNotificationRequestSubmitted);
    on<NotificationRequestGroupSubmitted>(_onNotificationRequestGroupSubmitted);

    add(NotificationInited());

    _newNotificationStreamSubscription = socket_repo
        .SocketAPI.socketApi.newNotificationController.stream
        .listen((_) {
      add(NotificationInited());
    });
  }

  final notification_repository.NotificationRepository _notificationRepository;
  final auth_repository.AuthRepository _authRepository;
  final friend_repository.FriendRepository _friendRepository;
  final chat_room_repository.ChatRoomRepository _chatRoomRepository;
  late final StreamSubscription<socket_repo.Notification>
      _newNotificationStreamSubscription;

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
          if (event.typeAction == "accept") {
            FlutterToastCustom.showToast(
                "Accepted invitation successfully", "success");
          } else if (event.typeAction == "denied") {
            FlutterToastCustom.showToast(
                "Denied invitation successfully", "success");
          }
          add(NotificationInited());
        }
      }
    } catch (err) {
      emit(NotificationGetListFailure());
    }
  }

  Future<void> _onNotificationRequestGroupSubmitted(
      NotificationRequestGroupSubmitted event,
      Emitter<NotificationState> emit) async {
    try {
      final bearerToken = await _authRepository.bearToken;

      if (bearerToken != null &&
          state.runtimeType == NotificationGetListSuccess) {
        if (event.type == "accept") {
          final isActionSuccess = await _chatRoomRepository.acceptJoinChat(
              bearerToken, event.chatRoomId);
          if (isActionSuccess) {
            FlutterToastCustom.showToast(
                "Accepted invitation successfully", "success");
            add(NotificationInited());
          } else {
            FlutterToastCustom.showToast("Action failed", "error");
          }
        }
        if (event.type == "reject") {
          final isActionSuccess = await _chatRoomRepository.rejectJoinChat(
              bearerToken, event.chatRoomId);
          if (isActionSuccess) {
            FlutterToastCustom.showToast(
                "Denied invitation successfully", "success");
            add(NotificationInited());
          } else {
            FlutterToastCustom.showToast("Action failed", "error");
          }
        }
      }
    } catch (e) {
      FlutterToastCustom.showToast(e.toString(), "error");
    }
  }

  @override
  Future<void> close() {
    _newNotificationStreamSubscription.cancel();
    return super.close();
  }
}
