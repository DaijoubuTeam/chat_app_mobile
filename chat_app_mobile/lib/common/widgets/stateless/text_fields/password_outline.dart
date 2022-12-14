import 'package:flutter/material.dart';

class PasswordOutline extends StatelessWidget {
  const PasswordOutline({
    Key? key,
    required TextEditingController inputController,
    bool? isPasswordVisible,
    String? errorText,
    String? labelText,
    required this.handleOnPressVisibleButton,
  })  : _inputController = inputController,
        _isPasswordVisible = isPasswordVisible ?? false,
        _errorText = errorText,
        _labelText = labelText,
        super(key: key);
  final TextEditingController _inputController;
  final bool _isPasswordVisible;
  final String? _errorText;
  final String? _labelText;
  final void Function() handleOnPressVisibleButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      decoration: InputDecoration(
        hintText: 'Your Password ...',
        labelText: _labelText ?? 'Password (*)',
        errorText: _errorText,
        // errorText: _errorText,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: _isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility_off),
          onPressed: handleOnPressVisibleButton,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      obscureText: _isPasswordVisible,
    );
  }
}
