import 'package:flutter/material.dart';

class ConfirmDiaglog {
  static void showConfirmDialog(BuildContext context, String title,
      String content, List<Widget> actions) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }
}
