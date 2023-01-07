import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app_mobile/services/notifications/local_notification.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:chat_app_mobile/utils/device_infor.dart';
import 'package:chat_app_mobile/utils/select_notification_stream.dart';
import 'package:device_repository/device_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/notification_repository.dart'
    as notifi_repo;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_repository/socket_repository.dart' as socket_repo;
import 'package:webrtc_repository/webrtc_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
    required WebRTCRepostiory webRTCRepostiory,
    required DeviceRepository deviceRepository,
    required notifi_repo.NotificationRepository notificationRepository,
  })  : _authRepository = authRepository,
        _webRTCRepostiory = webRTCRepostiory,
        _deviceRepository = deviceRepository,
        _notificationRepository = notificationRepository,
        super(AppStateLoading()) {
    on<AppLoaded>(_onAppLoaded);
    on<AppLogOutRequested>(_onAppLogOutRequested);
    on<AppUserChanged>(_onAppUserChanged);
    on<AppNotificationNumberChanged>(_onAppNotificationNumberChanged);

    _userSubscription = _authRepository.user.listen((user) {
      add(AppUserChanged(user));
    });

    _subcribeNotification();
    _subscribeWebRTC();
    _subscribeFirebaeMessaging();
  }

  final AuthRepository _authRepository;
  final WebRTCRepostiory _webRTCRepostiory;
  final DeviceRepository _deviceRepository;
  final notifi_repo.NotificationRepository _notificationRepository;

  late final StreamSubscription<User> _userSubscription;
  late final StreamSubscription<socket_repo.Notification>
      _newNotificationStreamSubscription;
  late final StreamSubscription<dynamic> _webRTCStreamSubscription;

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
      add(AppNotificationNumberChanged());
      emit(AppStateAuthorized(
        isEmailVerified: event.user.isEmailVerified ?? false,
        isProfileFilled: event.user.isProfileFilled ?? false,
      ));
      _addNewDeviceInformation();
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
            type: "call-notification",
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
      add(AppNotificationNumberChanged());
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
          id: 456,
          title: notification.notificationSender!.fullname.toString(),
          body: "invited you to join their group",
          payload: SelectNotificationStream.normalNotification,
        );
      }
    });
  }

  Future<String?> _getFcmToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;

    String? fcmToken = await firebaseMessage.getToken();

    return (fcmToken == null) ? "" : fcmToken;
  }

  void _addNewDeviceInformation() async {
    String? fcmToken = await _getFcmToken();

    String? deviceId = await DeviceInfor.getAndroidId();

    String? deviceModel = await DeviceInfor.getDeviceModel();

    final bearerToken = await _authRepository.bearToken;

    if (fcmToken != null &&
        deviceId != null &&
        deviceModel != null &&
        bearerToken != null) {
      _deviceRepository.postDevice(
          bearerToken, deviceId, deviceModel, fcmToken);
    }
  }

  void _subscribeFirebaeMessaging() {
    if (state is AppStateAuthorized) {
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        String? deviceId = await DeviceInfor.getAndroidId();

        String? deviceModel = await DeviceInfor.getDeviceModel();

        final bearerToken = await _authRepository.bearToken;

        if (deviceId != null && deviceModel != null && bearerToken != null) {
          _deviceRepository.postDevice(
              bearerToken, deviceId, deviceModel, fcmToken);
        }
      }).onError((err) {
        log(err.toString());
      });
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _newNotificationStreamSubscription.cancel();
    _webRTCStreamSubscription.cancel();
    return super.close();
  }

  Future<void> _onAppNotificationNumberChanged(
      AppNotificationNumberChanged event, Emitter<AppState> emit) async {
    if (state is AppStateAuthorized) {
      final bearerToken = await _authRepository.bearToken;
      if (bearerToken != null) {
        final listNotification =
            await _notificationRepository.getUserNotification(bearerToken);
        // emit((state as AppStateAuthorized)
        //     .copyWith(numberNotification: listNotification.length));
        final currentState = (state as AppStateAuthorized);
        emit(AppStateAuthorized(
            isEmailVerified: currentState.isEmailVerified,
            isProfileFilled: currentState.isProfileFilled,
            numberNotification: listNotification.length));
      }
    }
  }
}
