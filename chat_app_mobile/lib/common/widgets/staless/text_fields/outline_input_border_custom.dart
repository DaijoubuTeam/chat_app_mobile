import 'package:flutter/material.dart';

class OutlineInputBorderCustom extends StatelessWidget {
  const OutlineInputBorderCustom({
    super.key,
    required this.inputController,
    this.inputType,
    this.labelText,
    this.icon,
  });
  final TextEditingController inputController;
  final TextInputType? inputType;
  final String? labelText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: icon,
        helperText: '',
      ),
    );
  }
}
