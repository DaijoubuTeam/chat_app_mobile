import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StickerOptions extends StatelessWidget {
  const StickerOptions({Key? key, this.isShowing = false}) : super(key: key);

  final bool isShowing;

  void handleSendSticker(BuildContext ctx, String content) {
    ctx
        .read<ChatDetailBloc>()
        .add(ChatDetailSpecificSubmitted(content: content, type: "sticker"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isShowing
          ? SizedBox(
              height: 250.h,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi1'),
                      child: Image.asset(
                        'assets/stickers/mimi1.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi2'),
                      child: Image.asset(
                        'assets/stickers/mimi2.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi3'),
                      child: Image.asset(
                        'assets/stickers/mimi3.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi4'),
                      child: Image.asset(
                        'assets/stickers/mimi4.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi5'),
                      child: Image.asset(
                        'assets/stickers/mimi5.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi6'),
                      child: Image.asset(
                        'assets/stickers/mimi6.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi7'),
                      child: Image.asset(
                        'assets/stickers/mimi7.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi8'),
                      child: Image.asset(
                        'assets/stickers/mimi8.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton(
                      onPressed: () => handleSendSticker(context, 'mimi9'),
                      child: Image.asset(
                        'assets/stickers/mimi9.gif',
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );

    // : const SizedBox.shrink();
  }
}
