import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/utils/date_time_local_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioMessage extends IMessageItem {
  const AudioMessage({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return AudioMessageItem(
      url: content,
    );
  }
}

class AudioMessageItem extends StatefulWidget {
  const AudioMessageItem({super.key, required this.url});

  final String url;

  @override
  State<AudioMessageItem> createState() => _AudioMessageItemState();
}

class _AudioMessageItemState extends State<AudioMessageItem> {
  final audioPlayer = AudioPlayer();
  bool isPlay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future _setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.release);

    audioPlayer.setSourceUrl(widget.url);
  }

  @override
  void initState() {
    super.initState();

    _setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlay = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          child: IconButton(
            onPressed: () async {
              if (!isPlay) {
                // await audioPlayer.play(UrlSource(widget.url));
                await audioPlayer.resume();
              } else {
                await audioPlayer.pause();
              }
            },
            icon: Icon(isPlay ? Icons.pause : Icons.play_arrow),
            iconSize: 50,
          ),
        ),
        Column(
          children: [
            Slider(
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateTimeLocalString.formatTime(position)),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(DateTimeLocalString.formatTime(duration - position)),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
