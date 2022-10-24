import 'package:flutter/material.dart';

class ChatAppBarTitle extends StatelessWidget {
  const ChatAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              maxRadius: 20,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Nguyen Dinh Nhat Quang',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Active 3m ago',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }
}
