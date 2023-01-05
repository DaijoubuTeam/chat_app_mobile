import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/utils/date_time_local_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioMessage extends IMessageItem {
  const AudioMessage({
    super.key,
    required this.content,
    this.isMe = false,
  });

  final String content;
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
          horizontal: 2,
          vertical: 2,
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
            width: 2,
          ),
        ),
        child: AudioMessageItem(
          url: content,
          isMe: isMe,
        ),
      ),
    );
  }
}

class AudioMessageItem extends StatefulWidget {
  const AudioMessageItem({
    super.key,
    required this.url,
    this.isMe = false,
  });

  final String url;
  final bool isMe;

  @override
  State<AudioMessageItem> createState() => _AudioMessageItemState();
}

class _AudioMessageItemState extends State<AudioMessageItem> {
  final audioPlayer = AudioPlayer();
  bool isPlay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future _setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.setSourceUrl(widget.url);
  }

  @override
  void initState() {
    super.initState();

    _setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlay = state == PlayerState.playing;
        });
      }
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor:
              widget.isMe ? Colors.white : Theme.of(context).primaryColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () async {
                    if (!isPlay) {
                      // await audioPlayer.play(UrlSource(widget.url));
                      await audioPlayer.resume();
                    } else {
                      await audioPlayer.pause();
                    }
                  },
                  icon: Icon(
                    isPlay ? Icons.pause : Icons.play_arrow,
                    color: widget.isMe
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                  iconSize: 24,
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 160.w,
                  child: Slider(
                    min: 0.0,
                    activeColor: widget.isMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    thumbColor: widget.isMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    inactiveColor: widget.isMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                      //await audioPlayer.resume();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateTimeLocalString.formatTime(position),
                  style: TextStyle(
                    color: widget.isMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 48.w,
                ),
                Text(
                  DateTimeLocalString.formatTime(duration),
                  style: TextStyle(
                    color: widget.isMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ],
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
