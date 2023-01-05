import 'package:chat_app_mobile/common/widgets/stateless/message_item/audio_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/emoji_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/image_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/sticker_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/system_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/text_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/video_message_item.dart';

class FactoryMessageItem {
  static IMessageItem buildMessageItem(
    String? type,
    bool? isMe,
    String? content,
    String? nameActor,
  ) {
    switch (type) {
      case "text":
        {
          return TextMessageItem(content: content, isMe: isMe ?? false);
        }
      case "image":
        {
          return ImageMessageItem(content: content, isMe: isMe ?? false);
        }
      case "emoji":
        {
          return EmojiMessageItem(content: content!);
        }
      case "sticker":
        {
          return StickerMessageItem(content: content!);
        }
      case "system":
        {
          return SystemMessageItem(nameActor: nameActor, content: content!);
        }
      case "video":
        {
          return VideoMessageItem(
            isMe: isMe ?? false,
            content: content,
          );
        }
      case "record":
        {
          return AudioMessage(
            content: content!,
            isMe: isMe ?? false,
          );
        }
      default:
        {
          return TextMessageItem(content: content, isMe: isMe ?? false);
        }
    }
  }
}
