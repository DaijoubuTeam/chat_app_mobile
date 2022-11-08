import 'package:flutter/material.dart';

class MultilineInputBorderCustom extends StatelessWidget {
  const MultilineInputBorderCustom({
    super.key,
    required this.inputController,
    this.labelText,
    this.icon,
  });
  final TextEditingController inputController;
  final String? labelText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Align(
          alignment: Alignment.topCenter,
          widthFactor: 1.0,
          heightFactor: 3.3,
          child: icon,
        ),
        helperText: '',
      ),
    );
  }
}
