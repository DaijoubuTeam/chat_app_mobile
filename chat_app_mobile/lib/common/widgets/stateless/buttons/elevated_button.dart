import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom({
    super.key,
    required this.onPressed,
    this.text,
    this.backgroundColor,
  });

  final Function()? onPressed;
  final String? text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        // border radius
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text ?? '',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
