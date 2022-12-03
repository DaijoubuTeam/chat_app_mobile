import 'package:chat_app_mobile/common/widgets/stateless/message_item/factory_message_item.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart'
    as message_repository;

class MessageItem extends StatefulWidget {
  const MessageItem(
      {super.key,
      required this.isMe,
      required this.content,
      required this.friendAvatar,
      this.type = "text",
      this.readed});

  final bool isMe;
  final String content;
  final String? friendAvatar;
  final String? type;
  final List<message_repository.User>? readed;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool isTapping = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: (widget.friendAvatar != null)
                      ? NetworkImage(widget.friendAvatar!)
                      : const AssetImage("assets/images/empty_avatar.png")
                          as ImageProvider,
                ),
                const SizedBox(
                  width: 8,
                )
              ],
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTapping = !isTapping;
                      });
                    },
                    onLongPress: () {},
                    child: FactoryMessageItem.buildMessageItem(
                      widget.type,
                      widget.isMe,
                      widget.content,
                    ),
                  ),
                  if (isTapping)
                    Text(
                      "Not seen",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
