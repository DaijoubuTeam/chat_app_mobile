import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/toasts/flutter_toast.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_repository/message_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class VoicePage extends StatelessWidget {
  const VoicePage({
    super.key,
    required this.chatRoomId,
  });

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailBloc(
        chatRoomId: chatRoomId,
        chatRoomRepository: context.read<ChatRoomRepository>(),
        authRepository: context.read<AuthRepository>(),
        messageRepository: context.read<MessageRepository>(),
      ),
      child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
        builder: (context, state) {
          return const VoiceSound();
        },
      ),
    );
  }
}

class VoiceSound extends StatefulWidget {
  const VoiceSound({super.key});

  @override
  State<VoiceSound> createState() => _VoiceSoundState();
}

class _VoiceSoundState extends State<VoiceSound> {
  final recorder = FlutterSoundRecorder();
  bool isRecordeReady = false;
  bool isSentReaday = false;
  XFile? pathFile;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      FlutterToastCustom.showToast("Cannot record message", "error");
      return;
    }

    await recorder.openRecorder();
    setState(() {
      isRecordeReady = true;
    });
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecordeReady) return;
    await recorder.startRecorder(toFile: "audio");
  }

  Future stop() async {
    if (!isRecordeReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = XFile(path!);
    setState(() {
      isSentReaday = true;
      pathFile = audioFile;
    });
  }

  void _handleSendRecord(BuildContext ctx) {
    if (pathFile != null) {
      ctx
          .read<ChatDetailBloc>()
          .add(ChatDetailVoiceSubmitted(fileVideo: pathFile!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              String twoDigits(int n) => n.toString().padLeft(0);

              final twoDigitsMinutes =
                  twoDigits(duration.inMinutes.remainder(60));

              final twoDigitsSeconds =
                  twoDigits(duration.inSeconds.remainder(60));

              return Text(
                '$twoDigitsMinutes : $twoDigitsSeconds s',
                style: TextStyle(
                  fontSize: 80.sp,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
        Center(
          child: ElevatedButton(
            child: Icon(
              recorder.isRecording ? Icons.stop : Icons.mic,
              size: 80.sp,
            ),
            onPressed: () async {
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
              setState(() {});
            },
          ),
        ),
        if (isSentReaday)
          Center(
            child: ElevatedButton(
              child: Icon(
                Icons.send_outlined,
                size: 80.sp,
              ),
              onPressed: () => _handleSendRecord(context),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }
}
