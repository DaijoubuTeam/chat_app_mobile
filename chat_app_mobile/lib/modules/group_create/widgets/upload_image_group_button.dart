import 'package:flutter/material.dart';

class UploadImageGroupButton extends StatelessWidget {
  const UploadImageGroupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(2),
        iconSize: 48,
        icon: const Icon(
          Icons.add_a_photo,
          color: Colors.black,
        ),
        onPressed: () => {},
      ),
    );
  }
}
