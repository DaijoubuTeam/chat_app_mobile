import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/services/webrtc/signaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_repository/webrtc_repository.dart';
import 'package:socket_repository/socket_repository.dart';

class VideosContainer extends StatefulWidget {
  const VideosContainer({super.key, required this.friendId});

  final String friendId;

  @override
  State<VideosContainer> createState() => _VideosContainerState();
}

class _VideosContainerState extends State<VideosContainer> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool isWaiting = false;

  Future<void> openUserMedia() async {
    _localRenderer.srcObject = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});
    setState(() {});
  }

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    if (mounted) {
      Signaling().setWebRTCRepository(context.read<WebRTCRepostiory>());
      inviteCall(context);
      //createCallRoom(context);
    }

    super.initState();
  }

  void inviteCall(BuildContext ctx) async {
    final bearerToken = await ctx.read<AuthRepository>().bearToken;
    if (bearerToken != null) {
      Signaling().inviteCall(bearerToken, widget.friendId);
      setState(() {
        isWaiting = true;
      });
      SocketAPI.socketApi.webRTCStream.stream.listen((data) {
        setState(() {
          isWaiting = false;
        });
        if (data["data"]["type"] == "reject") {
          if (mounted) {
            ctx.pop();
          }
        }
      });
    }
  }

  void createCallRoom(BuildContext ctx) async {
    final bearerToken = await ctx.read<AuthRepository>().bearToken;
    if (bearerToken != null) {
      Signaling().createRoom(_localRenderer.srcObject,
          _remoteRenderer.srcObject, bearerToken, widget.friendId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isWaiting) {
      return const Center(
        child: CircularProgressIndicator(),
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
                )),
                Expanded(child: RTCVideoView(_remoteRenderer)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8)
      ],
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
