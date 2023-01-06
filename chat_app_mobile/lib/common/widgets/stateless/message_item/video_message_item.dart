import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoMessageItem extends IMessageItem {
  const VideoMessageItem({
    super.key,
    this.content,
    this.isMe = false,
  });

  final String? content;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: isMe
          ? const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16))
          : const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topRight: Radius.circular(16)),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[500] : Colors.white,
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(16))
              : const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topRight: Radius.circular(16)),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: content != null ? VideoPlayerView(url: content!) : Container(),
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: VideoPlayer(_controller)),
                )
              : Skeleton.rectangular(
                  width: 200.w,
                  height: 280.h,
                ),
        ),
        if (_controller.value.isInitialized)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.black38,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => VideoPlayPage(
                        url: widget.url,
                      ),
                    ),
                  );
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key, required this.url});

  static String namePage = "video-play-page";

  final String url;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Video"),
        backgroundColor: Colors.black,
      ),
      body: Stack(children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Loading....",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
        ),
        _controller.value.isInitialized
            ? Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: FloatingActionButton(
                  elevation: 20,
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
