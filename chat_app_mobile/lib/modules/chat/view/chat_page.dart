import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/chat/view/components/chat_items.dart';
import 'package:chat_app_mobile/modules/chat/view/components/chat_place_holder.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Expanded(
              child: Text(
                'CS Chat App',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: null,
          builder: (context, snapshot) {
            if (false) {
              //return const CircularProgressIndicator();
              return const ChatPlaceHolder();
            } else {
              return const ChatItems();
            }
          },
        ),
      ),
    );
  }
}
