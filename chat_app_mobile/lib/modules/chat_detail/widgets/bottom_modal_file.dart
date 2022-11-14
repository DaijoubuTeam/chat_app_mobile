import 'package:flutter/material.dart';

class BottomModalFile extends StatelessWidget {
  const BottomModalFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              Text("Upload"),
              SizedBox(
                width: 10,
              ),
              Text("Cancel"),
            ],
          ),
          // area show image
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[350],
            ),
          ),
          Wrap(
            children: [
              iconTextButton("Take a photo", Colors.orange, () {},
                  Icon(Icons.camera_alt_outlined)),
            ],
          )
        ],
      ),
    );
  }
}

Widget iconTextButton(String name, Color color, Function function, Icon icon) {
  return Container(
    child: Column(
      children: [
        Container(
          child: icon,
        ),
        Text(name),
      ],
    ),
  );
}
