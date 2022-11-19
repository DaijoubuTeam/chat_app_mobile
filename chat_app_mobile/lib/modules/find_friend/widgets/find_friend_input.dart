import 'package:chat_app_mobile/common/widgets/stateless/text_fields/outline_input_border_custom.dart';
import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindFriendInput extends StatefulWidget {
  const FindFriendInput({super.key});

  @override
  State<FindFriendInput> createState() => _FindFriendInputState();
}

class _FindFriendInputState extends State<FindFriendInput> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() => context
        .read<FindFriendBloc>()
        .add(FindFriendInputSearchChanged(_inputController.text)));

    return OutlineInputBorderCustom(
      inputController: _inputController,
      labelText: "Email/Phone number",
      hintText: "Search user by email or phone number",
      icon: const Icon(Icons.search),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
