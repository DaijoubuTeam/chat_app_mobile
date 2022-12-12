import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

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
    setState(() {});
  }

  @override
  void initState() {
    _localRenderer.initialize();
    //_remoteRenderer.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                //Expanded(child: RTCVideoView(_remoteRenderer)),
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
    super.dispose();
  }
}
