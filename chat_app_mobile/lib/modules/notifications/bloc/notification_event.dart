part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationInited extends NotificationEvent {}

class NotificationRequestSubmitted extends NotificationEvent {
  const NotificationRequestSubmitted({
    required this.typeAction,
    required this.idSender,
  });

  final String typeAction;
  final String idSender;

  @override
  List<Object> get props => [typeAction];
}
