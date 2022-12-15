import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isRemoteCameraOpen = true;
  bool isCameraOpen = true;
  bool isMicOpen = true;

  Future<void> openUserMedia() async {
    _localRenderer.srcObject = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});
    _remoteRenderer.srcObject = await createLocalMediaStream('remote-renderer');
    setState(() {});
  }

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    Signaling().onAddRemoteStream = (stream) {
      _remoteRenderer.srcObject = stream;
      final index =
          stream.getVideoTracks().indexWhere((track) => track.kind == 'video');
      if (index != -1) {
        setState(() {
          isRemoteCameraOpen = true;
        });
      } else {
        setState(() {
          isRemoteCameraOpen = false;
        });
      }
    };

    if (mounted) {
      Signaling().setWebRTCRepository(context.read<WebRTCRepostiory>());
      Signaling().closeVideoRenderer = () {
        print("close video renderer");
        List<MediaStreamTrack> tracks = _localRenderer.srcObject!.getTracks();
        for (var track in tracks) {
          track.stop();
        }
        List<MediaStreamTrack> remoteTracks =
            _remoteRenderer.srcObject!.getTracks();
        for (var remoteTrack in remoteTracks) {
          remoteTrack.stop();
        }
        _localRenderer.dispose();
        _localRenderer.srcObject?.dispose();
        _remoteRenderer.dispose();
        _remoteRenderer.srcObject?.dispose();
        context.pop();
      };
    }

    super.initState();
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

  Function _closeMedia(String kind, Function setStateTrack) {
    return () async {
      final track = _localRenderer.srcObject
          ?.getTracks()
          .firstWhereOrNull((track) => track.kind == kind);
      if (track != null) {
        // _localRenderer.srcObject?.removeTrack(cameraTrack);
        track.enabled = !track.enabled;
        setStateTrack(track);
        // setState(
        //   () => {
        //     isCameraOpen = cameraTrack.enabled,
        //   },
        // );
      }
    };
  }

  void _closeCamera() async {
    _closeMedia(
      "video",
      (MediaStreamTrack track) => {
        setState(() => {
              isCameraOpen = track.enabled,
            })
      },
    )();
  }

  void _closeMic() async {
    _closeMedia(
      "audio",
      (MediaStreamTrack track) => {
        setState(() => {
              isMicOpen = track.enabled,
            })
      },
    )();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(listener: (context, state) {
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
        context.pop();
      }
    }, builder: (context, state) {
      if (state.isWaiting) {
        return Stack(
          children: const [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }
      return Center(
        child: Stack(
          children: [
            isRemoteCameraOpen
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : Container(
                    color: Colors.black,
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
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                    SizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.white,
                        onPressed: _closeCamera,
                        child: Icon(
                          isCameraOpen
                              ? Icons.videocam_outlined
                              : Icons.videocam_off_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.cameraswitch),
                    // ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 64.0,
                      height: 64.0,
                      child: FloatingActionButton(
                        heroTag: null,
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
                        heroTag: null,
                        backgroundColor: Colors.white,
                        onPressed: _closeMic,
                        child: Icon(
                          isMicOpen ? Icons.mic : Icons.mic_off_outlined,
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
    });
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
    super.dispose();
  }
}
