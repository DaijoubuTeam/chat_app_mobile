import 'package:flutter/material.dart';

import 'bottom_modal_file.dart';

class ButtonFilePopUp extends StatelessWidget {
  const ButtonFilePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: ((context) {
            return const BottomModalFile();
          }),
        );
      },
      icon: Icon(
        Icons.attach_file,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
