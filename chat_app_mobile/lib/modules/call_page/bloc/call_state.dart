part of 'call_bloc.dart';

class CallState extends Equatable {
  const CallState({
    required this.friendId,
    this.isWaiting = false,
    this.isCancel = false,
  });

  final String friendId;
  final bool isWaiting;
  final bool isCancel;

  CallState copyWith({bool? isWaiting, bool? isCancel}) {
    return CallState(
      friendId: friendId,
      isWaiting: isWaiting ?? this.isWaiting,
      isCancel: isCancel ?? this.isCancel,
    );
  }

  @override
  List<Object> get props => [friendId, isWaiting, isCancel];
}
