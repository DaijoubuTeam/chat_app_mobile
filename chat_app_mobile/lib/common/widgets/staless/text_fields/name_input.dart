import 'package:chat_app_mobile/common/widgets/staless/text_fields/custom_input.dart';
import 'package:flutter/material.dart';

class NameInput extends ICustomInput {
  const NameInput({super.key, required this.nameInputController});
  final TextEditingController nameInputController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameInputController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Fullname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.person),
        helperText: '',
      ),
    );
  }
}
