import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonGoToLastestMessage extends StatelessWidget {
  const ButtonGoToLastestMessage({super.key, this.labelButton});

  final String? labelButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        if (labelButton != null) {
          return FloatingActionButton.extended(
            icon: const Icon(Icons.arrow_downward),
            label: labelButton != null ? Text(labelButton!) : Container(),
            onPressed: () {},
          );
        }
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.arrow_downward,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.white,
          elevation: 2.0,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.blue, width: 1),
          ),
        );
      },
    );
  }
}
