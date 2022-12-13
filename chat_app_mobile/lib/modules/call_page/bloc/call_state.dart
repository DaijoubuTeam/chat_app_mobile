part of 'call_bloc.dart';

class CallState extends Equatable {
  const CallState({
    required this.friendId,
    required this.isReceiver,
    this.isWaiting = false,
    this.isCancel = false,
  });

  final String friendId;
  final bool isWaiting;
  final bool isCancel;
  final bool isReceiver;

  CallState copyWith({bool? isWaiting, bool? isCancel}) {
    return CallState(
      friendId: friendId,
      isReceiver: isReceiver,
      isWaiting: isWaiting ?? this.isWaiting,
      isCancel: isCancel ?? this.isCancel,
    );
  }

  @override
  List<Object> get props => [friendId, isReceiver, isWaiting, isCancel];
}
