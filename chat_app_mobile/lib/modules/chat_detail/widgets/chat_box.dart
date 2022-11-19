import 'package:chat_app_mobile/modules/chat_detail/widgets/button_file_pop_up.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/button_send.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_content_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/stateless/emoji/emoji_input.dart';
import '../bloc/chat_detail_bloc.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _inputController = TextEditingController();
  bool isShowEmoji = false;
  bool isShowSend = false;

  @override
  void initState() {
    _inputController.addListener(() => {
          context
              .read<ChatDetailBloc>()
              .add(ChatDetailContentChanging(_inputController.text)),
          if (mounted)
            {
              if (_inputController.text.isEmpty)
                {
                  setState(() {
                    isShowSend = false;
                  })
                }
              else
                {
                  setState(() {
                    isShowSend = true;
                  })
                }
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 32,
          color: Theme.of(context).primaryColor.withOpacity(0.08),
        ),
      ]),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.sentiment_satisfied_alt_outlined),
                onPressed: () => {
                  setState(() {
                    isShowEmoji = !isShowEmoji;
                  }),
                },
              ),
              ChatContentInput(
                inputController: _inputController,
              ),
              const SizedBox(
                width: 16,
              ),
              isShowSend
                  ? const ChatContentButtonSend()
                  : const ButtonFilePopUp(),
            ],
          ),
          EmojiInputCustom(
            emojiShowing: isShowEmoji,
            editingController: _inputController,
          ),
        ],
      ),
    );
  }
}
