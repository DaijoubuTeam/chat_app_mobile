import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChatContentInput extends StatelessWidget {
  const ChatContentInput({
    super.key,
    required this.inputController,
  });

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatDetailBloc, ChatDetailState>(
      listenWhen: (previous, current) =>
          previous != current &&
          current.status == FormzStatus.submissionSuccess,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          inputController.clear();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: inputController,
                    maxLines: 11,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Type Message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Icon(Icons.attach_file),
                // Icon(Icons.camera_alt_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
