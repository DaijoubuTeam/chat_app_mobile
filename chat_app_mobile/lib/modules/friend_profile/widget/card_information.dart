import 'package:flutter/material.dart';
import 'add_friend_button.dart';
import 'friend_information.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              FriendInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
