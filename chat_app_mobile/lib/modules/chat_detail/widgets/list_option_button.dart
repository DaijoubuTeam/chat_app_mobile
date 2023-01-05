import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hide_keyboard.dart';
import '../bloc/chat_detail_bloc.dart';

class ListOptionButton extends StatelessWidget {
  const ListOptionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            IconButton(
              icon: state.isShowSticker
                  ? Icon(
                      Icons.star_border_outlined,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(Icons.star_border_outlined),
              onPressed: () {
                FocusScope.of(context).unfocus();
                SettingsKeyboard.hideKeyBoard(context);
                context.read<ChatDetailBloc>().add(
                      ChatDetailShowOptionChanged(
                        isShowSticker: !state.isShowSticker,
                        isShowEmoji: false,
                        isShowSend: false,
                      ),
                    );
              },
            ),
            IconButton(
              icon: state.isShowEmoji
                  ? Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(Icons.sentiment_satisfied_alt_rounded),
              onPressed: () {
                FocusScope.of(context).unfocus();
                SettingsKeyboard.hideKeyBoard(context);
                context.read<ChatDetailBloc>().add(
                      ChatDetailShowOptionChanged(
                        isShowSticker: false,
                        isShowEmoji: !state.isShowEmoji,
                        isShowSend: false,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
