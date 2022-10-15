import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FindFriendInput extends StatefulWidget {
  const FindFriendInput({super.key});

  @override
  State<FindFriendInput> createState() => _FindFriendInputState();
}

class _FindFriendInputState extends State<FindFriendInput> {
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: 'Email/Phone',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.search),
        helperText: '',
      ),
    );
    ;
  }
}
