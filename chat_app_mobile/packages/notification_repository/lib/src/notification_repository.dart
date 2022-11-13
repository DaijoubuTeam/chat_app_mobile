import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;
import './models/models.dart' as notification_model;

class NotificationRepository {
  NotificationRepository(chat_app_api.ChatAppApi chatAppApi)
      : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<List<notification_model.Notification>> getUserNotification(
      String bearerToken) async {
    final List<chat_app_api.Notification> notificationsApi =
        await _chatAppApi.getUserNotification(bearerToken);

    final List<notification_model.Notification> notificationRepo =
        notificationsApi
            .map(
                (notificationApi) => notificationApi.toRepositoryNotification())
            .toList();

    return notificationRepo;
  }

  Future<bool> readNotification(
      String bearerToken, String notificationId) async {
    return await _chatAppApi.readNotification(bearerToken, notificationId);
  }

  Future<bool> deleteNotification(
      String bearerToken, String notificationId) async {
    return await _chatAppApi.deleteNotification(bearerToken, notificationId);
  }
}

extension on chat_app_api.Notification {
  notification_model.Notification toRepositoryNotification() {
    final notification = notification_model.Notification(
        id: id,
        notifyType: notifyType,
        readed: readed,
        notificationSender: notificationSender?.toRepositoryUser(),
        notificationReceiver: notificationReceiver?.toRepositoryUser(),
        chatRoomId: chatRoom?.chatRoomId,
        chatRoomAvatar: chatRoom?.chatRoomAvatar,
        chatRoomName: chatRoom?.chatRoomName);
    return notification;
  }
}

extension on chat_app_api.User {
  notification_model.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return notification_model.User.empty;
    }
    final user = notification_model.User(
      uid: uid,
      username: username,
      fullname: fullname,
      avatar: avatar,
      phone: phone,
      about: about,
      email: email,
      isEmailVerified: isEmailVerified,
      isProfileFilled: isProfileFilled,
    );
    return user;
  }
}
