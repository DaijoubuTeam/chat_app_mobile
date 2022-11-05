import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    _inputController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: Theme.of(context).primaryColor.withOpacity(0.08)),
      ]),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
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
            ),
            const SizedBox(
              width: 16,
            ),
            Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
