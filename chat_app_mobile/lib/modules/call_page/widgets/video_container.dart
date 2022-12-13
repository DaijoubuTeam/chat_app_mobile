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
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.isWaiting) {
          return Stack(
            children: [
              const Center(
                child: CircularProgressIndicator(),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.call_end),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            const SizedBox(height: 8),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    openUserMedia();
                    //_makeCall();
                  },
                  child: const Text("Open camera & microphone"),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        child: RTCVideoView(_localRenderer, mirror: true),
                      ),
                    ),
                    Expanded(child: RTCVideoView(_remoteRenderer)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
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
