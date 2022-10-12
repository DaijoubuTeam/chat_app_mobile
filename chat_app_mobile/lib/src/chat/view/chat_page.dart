import 'package:auth_repository/auth_repository.dart';
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
            if (true) {
              //return const CircularProgressIndicator();
              return Padding(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/ChatPlaceholder.jpeg",
                      // width: 320,
                      // height: 320,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          // border radius
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Find more friend',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Chat app');
            }
          },
        ),
      ),
    );
  }
}
