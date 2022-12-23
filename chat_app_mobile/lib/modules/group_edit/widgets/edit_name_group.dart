import 'package:chat_app_mobile/modules/group_edit/bloc/group_edit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNameGroup extends StatefulWidget {
  const EditNameGroup({super.key});

  @override
  State<EditNameGroup> createState() => _EditNameGroupState();
}

class _EditNameGroupState extends State<EditNameGroup> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void didChangeDependencies() {
    final initialValue =
        (context.read<GroupEditBloc>().state as GroupEditGetInforSuccess)
            .groupName;
    if (initialValue != null) {
      _inputController.text = initialValue;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() {
      context
          .read<GroupEditBloc>()
          .add(GroupEditInputChanged(input: _inputController.text));
    });

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: _inputController,
        decoration: InputDecoration(
            labelText: "Enter your group name",
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.sp,
            )),
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
