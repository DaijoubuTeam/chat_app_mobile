part of 'call_bloc.dart';

class CallState extends Equatable {
  const CallState({
    required this.friendId,
    required this.isReceiver,
    this.isWaiting = false,
    this.isCancel = false,
    this.offer,
  });

  final String friendId;
  final bool isWaiting;
  final bool isCancel;
  final bool isReceiver;
  final dynamic offer;

  CallState copyWith({bool? isWaiting, bool? isCancel, dynamic offer}) {
    return CallState(
      friendId: friendId,
      isReceiver: isReceiver,
      isWaiting: isWaiting ?? this.isWaiting,
      isCancel: isCancel ?? this.isCancel,
      offer: offer ?? this.offer,
    );
  }

  @override
  List<Object?> get props => [friendId, isReceiver, isWaiting, isCancel, offer];
}
