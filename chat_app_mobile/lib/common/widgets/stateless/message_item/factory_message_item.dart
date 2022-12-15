import 'package:chat_app_mobile/common/widgets/stateless/message_item/emoji_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/image_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/sticker_message_item.dart';
import 'package:chat_app_mobile/common/widgets/stateless/message_item/text_message_item.dart';

class FactoryMessageItem {
  static IMessageItem buildMessageItem(
    String? type,
    bool? isMe,
    String? content,
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
      default:
        {
          return TextMessageItem(content: content, isMe: isMe ?? false);
        }
    }
  }
}
