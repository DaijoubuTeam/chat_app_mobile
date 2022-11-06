import 'package:flutter/material.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return ListTile(
          onTap: () => {},
          minVerticalPadding: 20,
          leading: Stack(
            children: [
              // (chatRoomAvatar != null)
              //     ? CircleAvatar(
              //         backgroundImage: NetworkImage(chatRoomAvatar!),
              //         maxRadius: 24,
              //       )
              //     : CircleAvatar(
              //         backgroundColor: Theme.of(context).primaryColor,
              //         maxRadius: 24,
              //       ),
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                maxRadius: 24,
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: Container(
              //     height: 16,
              //     width: 16,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //         color: Colors.white,
              //         width: 3,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          title: const Text(
            '123',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }),
      itemCount: 50,
    );
  }
}
