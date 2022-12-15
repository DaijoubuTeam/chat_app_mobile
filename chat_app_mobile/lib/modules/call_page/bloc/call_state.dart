part of 'call_bloc.dart';

class CallState extends Equatable {
  const CallState({
    required this.friendId,
    required this.isReceiver,
    this.isWaiting = true,
    this.isCancel = false,
    this.isCameraOpen = true,
    this.isMicOpen = true,
    this.isRemoteCameraOpen = true,
    this.offer,
  });

  final String friendId;
  final bool isWaiting;
  final bool isCancel;
  final bool isReceiver;
  final bool isCameraOpen;
  final bool isMicOpen;
  final bool isRemoteCameraOpen;
  final dynamic offer;

  CallState copyWith({
    bool? isWaiting,
    bool? isCancel,
    bool? isCameraOpen,
    bool? isMicOpen,
    bool? isRemoteCameraOpen,
    dynamic offer,
  }) {
    return CallState(
      friendId: friendId,
      isReceiver: isReceiver,
      isWaiting: isWaiting ?? this.isWaiting,
      isCancel: isCancel ?? this.isCancel,
      isCameraOpen: isCameraOpen ?? this.isCameraOpen,
      isMicOpen: isMicOpen ?? this.isMicOpen,
      isRemoteCameraOpen: isRemoteCameraOpen ?? this.isRemoteCameraOpen,
      offer: offer ?? this.offer,
    );
  }

  @override
  List<Object?> get props => [
        friendId,
        isReceiver,
        isWaiting,
        isCancel,
        isCameraOpen,
        isMicOpen,
        isRemoteCameraOpen,
        offer,
      ];
}
