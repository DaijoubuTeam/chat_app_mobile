import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText = "",
    this.negativeBtnText = "",
    this.onPostivePressed,
    this.onNegativePressed,
  });

  final Color bgColor;
  final String title;
  final String message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        if (negativeBtnText != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onNegativePressed != null) {
                onNegativePressed!();
              }
            },
            child: Text(
              negativeBtnText!,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        if (positiveBtnText != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onPostivePressed != null) {
                onPostivePressed!();
              }
            },
            child: Text(
              positiveBtnText!,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
