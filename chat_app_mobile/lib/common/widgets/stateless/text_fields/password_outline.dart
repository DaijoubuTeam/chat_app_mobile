import 'package:flutter/material.dart';

class PasswordOutline extends StatelessWidget {
  const PasswordOutline({
    Key? key,
    required TextEditingController inputController,
    bool? isPasswordVisible,
    required this.handleOnPressVisibleButton,
  })  : _inputController = inputController,
        _isPasswordVisible = isPasswordVisible ?? false,
        super(key: key);
  final TextEditingController _inputController;
  final bool _isPasswordVisible;
  final void Function() handleOnPressVisibleButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      decoration: InputDecoration(
        hintText: 'Your Password ...',
        labelText: 'Password',
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
