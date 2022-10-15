import 'package:chat_app_mobile/src/common/widgets/staless/text_fields/custom_input.dart';
import 'package:chat_app_mobile/src/common/widgets/staless/text_fields/email_input.dart';
import 'package:chat_app_mobile/src/common/widgets/staless/text_fields/name_input.dart';
import 'package:flutter/material.dart';

enum InputType { email, name }

class CustomInputFactory {
  static ICustomInput getCustomInput(
      InputType type, TextEditingController controller) {
    switch (type) {
      case InputType.email:
        return EmailInput(emailController: controller);
      case InputType.name:
        return NameInput(nameInputController: controller);
    }
  }
}
