import 'package:chat_app_mobile/modules/chat_detail/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}

class ChatItems extends StatelessWidget {
  const ChatItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(
          name: "Jane Russel",
          messageText: "Awesome Setup",
          imageURL: "https://picsum.photos/200/300",
          time: "Now"),
      ChatUsers(
          name: "Glady's Murphy",
          messageText: "That's Great",
          imageURL: "https://picsum.photos/200/300",
          time: "Yesterday"),
      ChatUsers(
          name: "Jorge Henry",
          messageText: "Hey where are you?",
          imageURL: "https://picsum.photos/200/300",
          time: "31 Mar"),
      ChatUsers(
          name: "Philip Fox",
          messageText: "Busy! Call me in 20 mins",
          imageURL: "https://picsum.photos/200/300",
          time: "28 Mar"),
      ChatUsers(
          name: "Debra Hawkins",
          messageText: "Thankyou, It's awesome",
          imageURL: "https://picsum.photos/200/300",
          time: "23 Mar"),
      ChatUsers(
          name: "Jacob Pena",
          messageText: "will update you in evening",
          imageURL: "https://picsum.photos/200/300",
          time: "17 Mar"),
      ChatUsers(
          name: "Andrey Jones",
          messageText: "Can you please share the file?",
          imageURL: "https://picsum.photos/200/300",
          time: "24 Feb"),
      ChatUsers(
          name: "John Wick",
          messageText: "How are you?",
          imageURL: "https://picsum.photos/200/300",
          time: "18 Feb"),
    ];
    return ListView.builder(
      itemBuilder: ((context, index) {
        return ListTile(
          onTap: () {
            context.pushNamed(ChatDetailPage.namePage);
          },
          minVerticalPadding: 20,
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(chatUsers[index].imageURL),
                maxRadius: 24,
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
          title: const Text(
            'Nguyen Van A',
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
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text('14:01'),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "3",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      itemCount: chatUsers.length,
    );
  }
}
