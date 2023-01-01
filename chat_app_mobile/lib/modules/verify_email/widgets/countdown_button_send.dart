import 'package:chat_app_mobile/modules/verify_email/bloc/verify_email_bloc.dart';
import 'package:chat_app_mobile/modules/verify_email/widgets/button_resend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownButtonSend extends StatefulWidget {
  const CountdownButtonSend({super.key});

  @override
  State<CountdownButtonSend> createState() => _CountdownButtonSendState();
}

class _CountdownButtonSendState extends State<CountdownButtonSend> {
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
  bool isAbleButton = false;

  @override
  void initState() {
    super.initState();
    animationStart();
  }

  void animationStart() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    setState(() {
      isAbleButton = true;
    });
  }

  void handleClickButton(BuildContext ctx) {
    ctx.read<VerifyEmailBloc>().add(VerifyEmailInited());
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch +
          const Duration(seconds: 20).inMilliseconds;
      isAbleButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountdownTimer(
          endTime: endTime,
          onEnd: onEnd, // send the function
          widgetBuilder: ((_, time) {
            if (time == null) {
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'An email has been sent to your email with a link to verify your account. If you have not received the email after, you',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' can click the button',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    TextSpan(
                        text: ' below to request a resend email',
                        style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              );
            } else {
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'An email has been sent to your email with a link to verify your account. If you have not received the email after ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' ${time.sec}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    TextSpan(
                        text: ' seconds',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ],
                ),
              );
            }
          }),
        ),
        const SizedBox(
          height: 16,
        ),
        ButtonResend(
          isAble: isAbleButton,
          handleClickButton: () => handleClickButton(context),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
