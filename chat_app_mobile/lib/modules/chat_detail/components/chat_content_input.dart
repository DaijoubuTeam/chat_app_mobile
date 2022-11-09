import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContentInput extends StatefulWidget {
  const ChatContentInput({Key? key}) : super(key: key);

  @override
  State<ChatContentInput> createState() => _ChatContentInputState();
}

class _ChatContentInputState extends State<ChatContentInput> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    _inputController.addListener(() => {
          context
              .read<ChatDetailBloc>()
              .add(ChatDetailContentChanging(_inputController.text))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.sentiment_satisfied_alt_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _inputController,
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
      ),
    );
  }
}
