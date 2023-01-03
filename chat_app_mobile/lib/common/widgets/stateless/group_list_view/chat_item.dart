import 'package:flutter/material.dart';
import 'package:message_repository/message_repository.dart' as message_repo;

import '../../../../modules/chat_detail/widgets/message_item.dart';

class ChatItemMessage extends StatefulWidget {
  const ChatItemMessage({super.key, required this.message});

  final message_repo.Message message;

  @override
  State<ChatItemMessage> createState() => _ChatItemMessageState();
}

class _ChatItemMessageState extends State<ChatItemMessage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final message = widget.message;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: MessageItem(
        key: GlobalObjectKey(message.id),
        isMe: message.isMe ?? false,
        content: message.content!,
        friendAvatar: message.from?.avatar,
        readed: message.readed?.toList(),
        type: message.type,
        time: message.createdAt,
        nameActor: message.from?.fullname,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
