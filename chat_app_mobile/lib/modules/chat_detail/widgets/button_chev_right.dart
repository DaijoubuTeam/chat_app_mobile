import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hide_keyboard.dart';
import '../bloc/chat_detail_bloc.dart';

class ButtonChevRight extends StatelessWidget {
  const ButtonChevRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_right),
      onPressed: () {
        FocusScope.of(context).unfocus();
        SettingsKeyboard.hideKeyBoard(context);
        context.read<ChatDetailBloc>().add(
              const ChatDetailShowOptionChanged(
                isShowSend: false,
              ),
            );
      },
    );
  }
}
