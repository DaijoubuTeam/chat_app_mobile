import 'package:chat_app_mobile/modules/group_create/bloc/group_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldNameGroup extends StatefulWidget {
  const TextFieldNameGroup({Key? key}) : super(key: key);

  @override
  State<TextFieldNameGroup> createState() => _TextFieldNameGroupState();
}

class _TextFieldNameGroupState extends State<TextFieldNameGroup> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() {
      context
          .read<GroupCreateBloc>()
          .add(GroupCreateNameInputChanged(value: _inputController.text));
    });

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: _inputController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "Enter your group name",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Group name is null";
          }
          return null;
        },
      ),
    );
  }
}
