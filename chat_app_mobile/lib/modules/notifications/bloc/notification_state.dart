part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationGetListInProgress extends NotificationState {}

class NotificationGetListSuccess extends NotificationState {
  const NotificationGetListSuccess({required this.listNotification});

  final List<notification_repository.Notification> listNotification;

  @override
  List<Object> get props => [listNotification];
}

class NotificationGetListFailure extends NotificationState {}
