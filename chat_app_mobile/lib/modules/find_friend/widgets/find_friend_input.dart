import 'package:chat_app_mobile/modules/find_friend/bloc/find_friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindFriendInput extends StatefulWidget {
  const FindFriendInput({super.key});

  @override
  State<FindFriendInput> createState() => _FindFriendInputState();
}

class _FindFriendInputState extends State<FindFriendInput> {
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    inputController.addListener(() => context
        .read<FindFriendBloc>()
        .add(FindFriendInputSearchChanged(inputController.text)));
    return BlocListener<FindFriendBloc, FindFriendState>(
      listenWhen: (previous, current) =>
          previous.inputSearch != current.inputSearch,
      listener: (context, state) {
        inputController.text = state.inputSearch;
        inputController.selection = TextSelection.fromPosition(
            TextPosition(offset: inputController.text.length));
      },
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          labelText: 'Email/Phone',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.search),
          helperText: '',
        ),
      ),
    );
  }
}
