import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FindFriendButton extends StatelessWidget {
  const FindFriendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => {},
          // border radius
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Find Friend',
              style: TextStyle(fontSize: 16),
            ),
          )),
    );
  }
}
