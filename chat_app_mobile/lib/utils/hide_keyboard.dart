import 'package:flutter/material.dart';

class SettingsKeyboard {
  static void hideKeyBoard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
