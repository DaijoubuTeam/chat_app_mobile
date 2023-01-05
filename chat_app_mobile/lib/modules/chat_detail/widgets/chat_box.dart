import 'dart:developer';

import 'package:chat_app_mobile/modules/chat_detail/widgets/button_chev_right.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/button_file_pop_up.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/button_send.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/chat_content_input.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/list_option_button.dart';
import 'package:chat_app_mobile/modules/chat_detail/widgets/stickers_option.dart';
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
  final FocusNode _focus = FocusNode();
  final GlobalKey _formKey = GlobalKey<FormState>();

  void _onInputChanged() {
    if (_inputController.text.isNotEmpty) {
      context.read<ChatDetailBloc>().add(
            ChatDetailContentChanging(
                content: _inputController.text, type: "text"),
          );
      FocusScope.of(context).requestFocus();
    }
  }

  void _onFocusChange() {
    log("Focus: ${_focus.hasFocus.toString()}");
    if (_focus.hasFocus) {
      context.read<ChatDetailBloc>().add(
            const ChatDetailShowOptionChanged(
              isShowSend: true,
            ),
          );
    } else {
      context.read<ChatDetailBloc>().add(
            const ChatDetailShowOptionChanged(
              isShowSend: false,
            ),
          );
    }
  }

  @override
  void didChangeDependencies() {
    _inputController.addListener(_onInputChanged);
    _focus.addListener(_onFocusChange);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
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
                  state.isShowSend
                      ? const ButtonChevRight()
                      : const ListOptionButton(),
                  Expanded(
                    child: ChatContentInput(
                      globalKey: _formKey,
                      focus: _focus,
                      inputController: _inputController,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  state.isShowSend
                      ? const ChatContentButtonSend()
                      : const ButtonFilePopUp(),
                ],
              ),
              EmojiInputCustom(
                emojiShowing: state.isShowEmoji,
              ),
              StickerOptions(
                isShowing: state.isShowSticker,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _focus.removeListener(_onFocusChange);
    super.dispose();
  }
}
