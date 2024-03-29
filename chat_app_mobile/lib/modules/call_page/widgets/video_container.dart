import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_repository/webrtc_repository.dart';
import 'package:collection/collection.dart';

class VideosContainer extends StatefulWidget {
  const VideosContainer({super.key});

  @override
  State<VideosContainer> createState() => _VideosContainerState();
}

class _VideosContainerState extends State<VideosContainer> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  bool isMicOpen = true;
  bool isCameraOpen = true;
  bool isVolumeUp = true;
  bool isCameraSwitched = false;

  Future<void> openUserMedia() async {
    _localRenderer.srcObject = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});

    _remoteRenderer.srcObject = await createLocalMediaStream('remote-renderer');
    setState(() {});
  }

  @override
  void initState() {
    Signaling().isInCall = true;

    _localRenderer.initialize();
    _remoteRenderer.initialize();

    Signaling().onAddRemoteStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };
    super.initState();
    if (mounted) {
      Signaling().setWebRTCRepository(context.read<WebRTCRepostiory>());
      Signaling().closeVideoRenderer = () {
        List<MediaStreamTrack> tracks = _localRenderer.srcObject!.getTracks();
        for (var track in tracks) {
          track.stop();
        }
        List<MediaStreamTrack> remoteTracks =
            _remoteRenderer.srcObject!.getTracks();
        for (var remoteTrack in remoteTracks) {
          remoteTrack.stop();
        }
        cancelWebRTC().then((_) {
          context.pop();
        });
      };
    }
  }

  Future<void> cancelWebRTC() async {
    await _localRenderer.dispose();
    await _localRenderer.srcObject?.dispose();
    await _remoteRenderer.dispose();
    await _remoteRenderer.srcObject?.dispose();
  }

  Future<void> _createCallRoom(BuildContext ctx, String friendId) async {
    final bearerToken = await ctx.read<AuthRepository>().bearToken;
    if (bearerToken != null) {
      await openUserMedia();
      await Signaling().createRoom(_localRenderer.srcObject,
          _remoteRenderer.srcObject, bearerToken, friendId);
    }
  }

  Future<void> _joinCallRoom(
      BuildContext ctx, String friendId, dynamic data) async {
    final bearerToken = await ctx.read<AuthRepository>().bearToken;
    if (bearerToken != null) {
      await openUserMedia();
      await Signaling().joinRoom(data, _localRenderer.srcObject,
          _remoteRenderer.srcObject, bearerToken, friendId);
    }
  }

  Function _closeMedia(String kind, Function(bool) setStateTrack) {
    return () async {
      final track = _localRenderer.srcObject
          ?.getTracks()
          .firstWhereOrNull((track) => track.kind == kind);
      if (track != null) {
        track.enabled = !track.enabled;
        log("Enable camera ${track.enabled}");
        setStateTrack(track.enabled);
      }
    };
  }

  void _closeCamera(BuildContext ctx) async {
    _closeMedia(
      "video",
      (bool isTrackEnabled) {
        setState(() => {isCameraOpen = isTrackEnabled});
      },
    )();
    // if (videoTrack != null) {
    //   setState(() {
    //     videoTrack!.enabled = !videoTrack!.enabled;
    //   });

    //   ctx
    //       .read<CallBloc>()
    //       .add(CallCameraStatusChanged(isCameraOpen: videoTrack!.enabled));
    // }
  }

  void _closeMic(BuildContext ctx) async {
    _closeMedia(
      "audio",
      (bool isTrackEnabled) {
        setState((() => {
              isMicOpen = isTrackEnabled,
            }));
      },
    )();
    // if (audioTrack != null) {
    //   audioTrack!.enabled = !audioTrack!.enabled;
    //   ctx
    //       .read<CallBloc>()
    //       .add(CallCameraStatusChanged(isCameraOpen: audioTrack!.enabled));
    // }
  }

  void _switchCamera() {
    final track = _localRenderer.srcObject?.getVideoTracks().first;
    if (track != null) {
      Helper.switchCamera(track);
      setState(() {
        isCameraSwitched != isCameraSwitched;
      });
    }
  }

  void _muteRemoteSound() {
    final track = _remoteRenderer.srcObject?.getAudioTracks().first;
    if (track != null) {
      track.enabled = !track.enabled;
      log("Enable camera ${track.enabled}");
      setState(() {
        isVolumeUp = track.enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(
      listener: (context, state) {
        if (state.isReceiver) {
          if (state.isWaiting && !state.isCancel) {
            _createCallRoom(context, state.friendId).then((value) {
              context.read<CallBloc>().add(CallCreateRoomSucceeded());
            }).catchError((_) {
              context.read<CallBloc>().add(CallCreateRoomFailed());
            });
          }
        } else {
          if (!state.isCancel && !state.isWaiting) {
            _joinCallRoom(context, state.friendId, state.offer);
          }
        }
        if (state.isCancel && !state.isWaiting) {
          _localRenderer.srcObject?.dispose();
          _localRenderer.dispose();
          _remoteRenderer.srcObject?.dispose();
          _remoteRenderer.dispose();
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.isWaiting) {
          return Center(
            child: Container(
              height: double.infinity,
              color: Colors.black,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const Text(
                          "Calling...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 64.w,
                      height: 64.h,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.red[400],
                          onPressed: () {
                            context.read<CallBloc>().add(CallMissed());
                          },
                          child: const Icon(
                            Icons.call_end,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (state.isCancel) {
          return Container(
            color: Colors.black,
          );
        }
        return Center(
          child: Stack(
            children: [
              state.isRemoteCameraOpen
                  ? RTCVideoView(
                      _remoteRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : Container(
                      color: Colors.green,
                    ),
              if (isCameraOpen)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 120,
                    height: 200,
                    color: Colors.black,
                    child: RTCVideoView(
                      _localRenderer,
                      mirror: true,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // open camera
                      SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            _closeCamera(context);
                          },
                          child: Icon(
                            isCameraOpen
                                ? Icons.videocam_outlined
                                : Icons.videocam_off_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // switch camera
                      SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            _switchCamera();
                          },
                          child: Icon(
                            isCameraSwitched
                                ? Icons.flip_camera_ios
                                : Icons.flip_camera_ios_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 64.0,
                        height: 64.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.red[400],
                          onPressed: () {
                            Signaling().hangUp();
                          },
                          child: const Icon(
                            Icons.call_end,
                            size: 36,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () => _closeMic(context),
                          child: Icon(
                            isMicOpen ? Icons.mic : Icons.mic_off_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () => _muteRemoteSound(),
                          child: Icon(
                            isVolumeUp
                                ? Icons.volume_up_outlined
                                : Icons.volume_off_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Signaling().closeVideoRenderer = null;
    // if (_localRenderer != null && _remoteRenderer != null) {
    //   _localRenderer.dispose();
    //   _localRenderer.srcObject?.dispose();
    //   _remoteRenderer.dispose();
    //   _remoteRenderer.srcObject?.dispose();
    // }
    Signaling().isInCall = false;
    // Signaling().dispose();
    super.dispose();
  }
}
