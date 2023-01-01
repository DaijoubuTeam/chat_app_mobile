import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/services/notifications/local_notification.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:chat_app_mobile/utils/select_notification_stream.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_repository/socket_repository.dart' as socket_repo;
import 'package:webrtc_repository/webrtc_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
    required WebRTCRepostiory webRTCRepostiory,
  })  : _authRepository = authRepository,
        _webRTCRepostiory = webRTCRepostiory,
        super(AppStateLoading()) {
    on<AppLoaded>(_onAppLoaded);
    on<AppLogOutRequested>(_onAppLogOutRequested);
    on<AppUserChanged>(_onAppUserChanged);

    _userSubscription = _authRepository.user.listen((user) {
      add(AppUserChanged(user));
    });
    _subcribeNotification();
    _subscribeWebRTC();
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;
  late final StreamSubscription<socket_repo.Notification>
      _newNotificationStreamSubscription;
  late final StreamSubscription<dynamic> _webRTCStreamSubscription;
  final WebRTCRepostiory _webRTCRepostiory;

  User get authCurrentUser => _authRepository.currentUser;

  FutureOr<void> _onAppLoaded(AppLoaded event, Emitter<AppState> emit) {
    // final
  }

  Future<void> _onAppLogOutRequested(
      AppLogOutRequested event, Emitter<AppState> emit) async {
    await (_authRepository.logOut());
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    socket_repo.SocketAPI.socketApi.socketDisconnected();
    socket_repo.SocketAPI.socketApi.socketConnect().onConnect((data) {
      if (event.user != User.empty) {
        log(_authRepository.currentUser.uid);
        socket_repo.SocketAPI.socketApi
            .socketRegister(_authRepository.currentUser.uid);
      }
    });
    if (event.user != User.empty) {
      emit(AppStateAuthorized(
        isEmailVerified: event.user.isEmailVerified ?? false,
        isProfileFilled: event.user.isProfileFilled ?? false,
      ));
    } else {
      emit(AppStateUnAuthorized());
    }
  }

  void _subscribeWebRTC() {
    _webRTCStreamSubscription =
        socket_repo.SocketAPI.socketApi.webRTCStream.stream.listen((data) {
      if (data["data"]["type"] == "invite") {
        if (Signaling().isInCall) {
          _authRepository.bearToken?.then((token) {
            _webRTCRepostiory.postWebRTC(token, data["from"]["uid"], {
              "type": "busy",
            });
          });
        } else {
          NotificationService().showNotification(
            id: 123,
            title: data["from"]["fullname"],
            body: "call you",
            payload: data["from"]["uid"],
          );
        }
      }

      if (data["data"]["type"] == "missed") {
        NotificationService().cancelNotification(123);
      }
    });
  }

  void _subcribeNotification() {
    _newNotificationStreamSubscription = socket_repo
        .SocketAPI.socketApi.newNotificationController.stream
        .listen((notification) {
      if (notification.notifyType == "friend-request") {
        NotificationService().showNotification(
          id: 123,
          title: notification.notificationSender!.fullname.toString(),
          body: "want to be friends with you!",
          payload: SelectNotificationStream.normalNotification,
        );
      }
      if (notification.notifyType == "chat-room-invitation") {
        NotificationService().showNotification(
          id: 123,
          title: notification.notificationSender!.fullname.toString(),
          body: "invited you to join their group",
          payload: SelectNotificationStream.normalNotification,
        );
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _newNotificationStreamSubscription.cancel();
    _webRTCStreamSubscription.cancel();
    return super.close();
  }
}
