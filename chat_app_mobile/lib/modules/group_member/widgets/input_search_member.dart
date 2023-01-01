import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/group_member_bloc.dart';

class InputSearchMember extends StatefulWidget {
  const InputSearchMember({Key? key}) : super(key: key);

  @override
  State<InputSearchMember> createState() => _InputSearchMemberState();
}

class _InputSearchMemberState extends State<InputSearchMember> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() {
      context
          .read<GroupMemberBloc>()
          .add(GroupMemberInputSearchChanged(value: _inputController.text));
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _inputController,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Search your friends",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
