import 'package:chat_app_mobile/common/widgets/staless/text_fields/custom_input.dart';
import 'package:flutter/material.dart';

class EmailInput extends ICustomInput {
  const EmailInput({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.email),
        helperText: '',
      ),
    );
  }
}
