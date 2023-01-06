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
              child: GridView.builder(
                itemCount: 18,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: StickerButton(
                      stickerName: "mimi$index",
                    ),
                  );
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class StickerButton extends StatelessWidget {
  const StickerButton({
    Key? key,
    this.stickerName = 'mini1',
  }) : super(key: key);

  final String? stickerName;

  void _handleSendSticker(BuildContext ctx, String content) {
    ctx
        .read<ChatDetailBloc>()
        .add(ChatDetailSpecificSubmitted(content: content, type: "sticker"));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _handleSendSticker(context, "$stickerName"),
      child: Image.asset(
        'assets/stickers/$stickerName.gif',
        width: 64.w,
        height: 64.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
