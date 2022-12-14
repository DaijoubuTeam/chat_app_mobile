import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/call_page/bloc/call_bloc.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

class VideosContainer extends StatefulWidget {
  const VideosContainer({super.key});

  @override
  State<VideosContainer> createState() => _VideosContainerState();
}

class _VideosContainerState extends State<VideosContainer> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

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
      setState(() {});
    };

    if (mounted) {
      Signaling().setWebRTCRepository(context.read<WebRTCRepostiory>());
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
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }
      return Center(
        child: Stack(
          children: [
            RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
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
                        onPressed: () {},
                        child: const Icon(
                          Icons.videocam_off_outlined,
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
                        onPressed: () {},
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
                        onPressed: () {},
                        child: const Icon(
                          Icons.mic_off_outlined,
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
    _localRenderer.dispose();
    _localRenderer.srcObject?.dispose();
    _remoteRenderer.dispose();
    _remoteRenderer.srcObject?.dispose();
    super.dispose();
  }
}
