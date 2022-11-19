import 'package:flutter/material.dart';

class TextFieldNameGroup extends StatefulWidget {
  const TextFieldNameGroup({Key? key}) : super(key: key);

  @override
  State<TextFieldNameGroup> createState() => _TextFieldNameGroupState();
}

class _TextFieldNameGroupState extends State<TextFieldNameGroup> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: _inputController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "Enter your group name",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Group name is null";
          }
          return null;
        },
      ),
    );
  }
}
