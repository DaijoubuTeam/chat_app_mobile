import 'package:flutter/material.dart';

class DividerWithTextCenter extends StatelessWidget {
  const DividerWithTextCenter({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
      Text(title),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
    ]);
  }
}
