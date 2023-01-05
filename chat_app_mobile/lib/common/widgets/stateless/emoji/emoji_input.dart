import 'dart:io' show Platform;

import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmojiInputCustom extends StatelessWidget {
  const EmojiInputCustom({
    super.key,
    this.emojiShowing = false,
  });
  final bool emojiShowing;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
          onEmojiSelected: (_, Emoji emoji) {
            context.read<ChatDetailBloc>().add(
                  ChatDetailSpecificSubmitted(
                    content: emoji.emoji,
                    type: "emoji",
                  ),
                );
          },
          config: Config(
            columns: 7,
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax:
                24 * (Platform.isIOS || Platform.isMacOS ? 1.30 : 1.0),
            // (!foundation.kIsWeb && Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: Colors.transparent,
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            replaceEmojiOnLimitExceed: false,
            noRecents: const Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            loadingIndicator: const SizedBox.shrink(),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
            checkPlatformCompatibility: true,
          ),
        ),
      ),
    );
  }
}
